//
// Created by Rajib Singh on 6/18/16.
// Copyright (c) 2016 Sepoy Software. All rights reserved.
//

import Foundation
import Cocoa

class MandelView: NSView {

    fileprivate var startBox: NSPoint?
    fileprivate var endBox: NSPoint?
    @IBOutlet weak var imageView: NSImageView!
    fileprivate var renderer: MandelbrotRenderer?
    override var acceptsFirstResponder: Bool { return true }
    
    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func keyDown(with event: NSEvent) {
        NSLog("key down registered")
        NSLog("characters: \(event.characters) keycode: \(event.keyCode)")
        renderer!.zoomOut()
        let cgim: CGImage = renderer!.getImage()
        let nsImage: NSImage = NSImage(cgImage: cgim, size: imageView.frame.size)
        imageView.image = nsImage
        
    }

    override func mouseDown(with event: NSEvent) {
        NSLog("mouseDown event registered")
        let location = event.locationInWindow
        let local_point = convert(location, from: self)
        startBox = local_point
        NSLog("\tlocation:\(local_point.x), \(local_point.y)")
    }

//    override func mouseDragged(theEvent: NSEvent) {
//        NSLog("mouseDragged event registered")
//    }

    override func mouseUp(with event: NSEvent) {
        NSLog("mouseUp event registered")
        let location = event.locationInWindow
        let local_point = convert(location, from: self)
        endBox = local_point
        NSLog("\tlocation:\(local_point.x), \(local_point.y)")
        NSLog("\tstartBox:\(startBox)")
        NSLog("\tendBox:\(endBox)")
        NSLog("here we go ...")
        renderer!.zoomIn()
        let cgim: CGImage = renderer!.getImage()
        let nsImage: NSImage = NSImage(cgImage: cgim, size: imageView.frame.size)
        imageView.image = nsImage
    }

    override func mouseMoved(with theEvent: NSEvent) {
        NSLog("mouseDown event registered")
    }

    func acceptsFirstMouseEvent(_ theEvent: NSEvent) -> Bool {
        return true
    }
    
    func renderView(_ topLeft:ComplexNumber, bottomRight:ComplexNumber) {
        let frameSize: CGSize = imageView.frame.size
        let cgim: CGImage = renderer!.getImage()
        let nsImage: NSImage = NSImage(cgImage: cgim, size: frameSize)
        imageView.image = nsImage
    }
    
    
    func initRender() {
        let frameSize: CGSize = imageView.frame.size
        let tl: ComplexNumber = ComplexNumber(x: -2.0, y: 1.5)
        let br: ComplexNumber = ComplexNumber(x: 0.5, y: -1.25)
        renderer = MandelbrotRenderer(size: frameSize, topLeft: tl, bottomRight: br)
        renderView(tl, bottomRight: br)
    }
}
