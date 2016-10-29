//
// Created by Rajib Singh on 6/18/16.
// Copyright (c) 2016 Sepoy Software. All rights reserved.
//

import Cocoa
import Foundation

class MandelbrotRenderer {
    
    let size: CGSize
    fileprivate let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    fileprivate let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
    internal var topLeft: ComplexNumber
    internal var bottomRight: ComplexNumber
    fileprivate let THRESHOLD = 10
    fileprivate let MAXITERATIONS = 100
    fileprivate let offset: ComplexNumber

    struct PixelData {
        var a: UInt8 = 255
        var r: UInt8 = 0
        var g: UInt8 = 0
        var b: UInt8 = 0

        init(red: UInt8, green: UInt8, blue: UInt8) {
            self.r = UInt8(red)
            self.g = UInt8(green)
            self.b = UInt8(blue)
        }
    }

    init(size: CGSize, topLeft: ComplexNumber, bottomRight: ComplexNumber) {
        self.size = size
        self.topLeft = topLeft
        self.bottomRight = bottomRight
        let dX = (bottomRight.x - topLeft.x) / Double(size.width)
        let dY = (bottomRight.y - topLeft.y) / Double(size.height)
        offset = ComplexNumber(x: dX, y: dY)
    }

    // create a bitmap and send that to the NSImage in the app
    func getImage() -> CGImage {
        let bitsPerComponent: UInt = 8
        let bitsPerPixel: UInt = 32
        var pixels = [PixelData]()
        var countArray = [Int]()

        for stepY: Int in 0 ... Int(size.height) - 1 {
            for stepX: Int in 0 ... Int(size.width) - 1 {
                let x = topLeft.x + (Double(stepX) * offset.x)
                let y = topLeft.y + (Double(stepY) * offset.y)
                let c: ComplexNumber = ComplexNumber(x: x, y: y)
                let count = getCount(c)
                countArray.append(count)
            }
        }

        let maxcolors = analyzeForColors(countArray)
        print("maxcolors: \(maxcolors)")

        var red:UInt8 = 255
        var green:UInt8 = 255
        var blue:UInt8 = 255
        var colorDelta:UInt8 = 0

        for count in countArray {
            // black
            var pixel:PixelData
            if count == MAXITERATIONS {
                red = UInt8(0)
                green = UInt8(0)
                blue = UInt8(0)
            }
            // white
            else if count == 1 {
                red = UInt8(255)
                green = UInt8(255)
                blue = UInt8(255)
            }
            // red
            else if (count > 1 && count < 7) {
                colorDelta = UInt8(255 - (42 * (7 - count)))
                green = colorDelta
                blue = colorDelta
                red = 255
            // green
            } else if (count >= 7 && count < 9) {
                colorDelta = UInt8(255 - (85 * (9 - count )))
                red = colorDelta
                blue = colorDelta
                green = 255
            // blue
            } else if count <   MAXITERATIONS {
                colorDelta = UInt8(255 - (2 * (MAXITERATIONS - count)))
                red = colorDelta
                green = colorDelta
                blue = 255
            }
            pixel = PixelData(red: red, green: green, blue: blue)
            pixels.append(pixel)
        }

        let raw = Data(bytes: pixels, count: pixels.count * MemoryLayout<PixelData>.size)
        let providerRef = CGDataProvider(data: raw as CFData)
        let cgim = CGImage(width: Int(size.width), height: Int(size.height), bitsPerComponent: Int(bitsPerComponent), bitsPerPixel: Int(bitsPerPixel), bytesPerRow: Int(size.width) * MemoryLayout<PixelData>.size, space: rgbColorSpace, bitmapInfo: bitmapInfo, provider: providerRef!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
        print("pixels size is \(pixels.count)");
        print("countArray size is \(countArray.count)")
        return cgim!
    }

    func getCount(_ c: ComplexNumber) -> Int{
        var count = 0
        var z = ComplexNumber(x: 0, y: 0)
        while (count < MAXITERATIONS && z.size() < 2) {
            count = count + 1
            z = z.squaredPlus(c)
        }
        return count
    }
    
    func zoom(_ zoomPct:Double) {
        let ht = bottomRight.y - topLeft.y
        let wdth = bottomRight.x - topLeft.x
        
        let newTopLeftX = topLeft.x - wdth * zoomPct
        let newTopLeftY = topLeft.y - ht * zoomPct
        let newTopLeft = ComplexNumber(x: newTopLeftX, y: newTopLeftY)
        topLeft = newTopLeft
        
        let newBottomRightX = bottomRight.x - wdth * zoomPct
        let newBottomRightY = bottomRight.y
        let newBottomRight = ComplexNumber(x: newBottomRightX, y: newBottomRightY)
        bottomRight = newBottomRight
    }
    
    func zoomIn() {
        zoom(0.10)
    }
    
    func zoomOut() {
        zoom(-0.10)
    }

    // just does analysis for now. is not altering the generated bitmap.
    func analyzeForColors(_ input : [Int]) -> Int  {
        var counts = [Int : Int]()
        for count in input {
            if counts[count] != nil {
                counts[count] = counts[count]! + 1
            } else {
                counts[count] = 1
            }
        }
        print("sorting keys")
//        let keys = counts.keys.sorted()
//        for key in keys {
//                print("key: \(key) value: \(counts[key]!)")
//        }
        return counts.count
    }
    
    
}

class ComplexNumber: CustomStringConvertible {
    var x: Double = 0
    var y: Double = 0
    var description: String {
        return "(\(self.x), \(self.y)i)"
    }

    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    func size() -> Double {
        return sqrt(x * x + y * y)
    }

    func squaredPlus(_ c: ComplexNumber) -> ComplexNumber {
        return self.square().add(c)
    }

    func square() -> ComplexNumber {
        let newX = self.x * self.x - (y * y)
        let newY = (self.x * self.y) * 2
        return ComplexNumber(x: newX, y: newY)
    }

    func add(_ that: ComplexNumber) -> ComplexNumber {
        return ComplexNumber(x: self.x + that.x, y: self.y + that.y)
    }

    func isNear(_ that: ComplexNumber, distance: Int) -> Bool {
        let dX = that.x - self.x
        let dY = that.y - self.y
        if sqrt(dX * dX + dY * dY) <  Double(distance) {
            return true
        } else {
            return false
        }
    }

    func inBox(_ that: ComplexNumber, distance: Int) -> Bool {
        let dX = that.x - self.x
        let dY = that.y - self.y
        if abs(dX) < Double(distance) && abs(dY) < Double(distance) {
            return true
        } else {
            return false
        }
    }
}
