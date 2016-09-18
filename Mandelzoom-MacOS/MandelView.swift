//
// Created by Rajib Singh on 6/18/16.
// Copyright (c) 2016 Sepoy Software. All rights reserved.
//

import Foundation
import Cocoa

class MandelView: NSView {

    private var startBox: NSPoint?
    private var endBox: NSPoint?
    @IBOutlet weak var imageView: NSImageView!

    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func mouseDown(event: NSEvent) {
        NSLog("mouseDown event registered")
        var location = event.locationInWindow
        var local_point = convertPoint(location, fromView: self)
        startBox = local_point
        NSLog("\tlocation:\(local_point.x), \(local_point.y)")
    }

//    override func mouseDragged(theEvent: NSEvent) {
//        NSLog("mouseDragged event registered")
//    }

    override func mouseUp(event: NSEvent) {
        NSLog("mouseUp event registered")
        var location = event.locationInWindow
        var local_point = convertPoint(location, fromView: self)
        endBox = local_point
        NSLog("\tlocation:\(local_point.x), \(local_point.y)")
        NSLog("\tstartBox:\(startBox)")
        NSLog("\tendBox:\(endBox)")

    }

    override func mouseMoved(theEvent: NSEvent) {
        NSLog("mouseDown event registered")
    }

    func acceptsFirstMouseEvent(theEvent: NSEvent) -> Bool {
        return true
    }
    
    func doTheThing() {
        let frameSize: CGSize = imageView.frame.size
        let tl: ComplexNumber = ComplexNumber(x: -2.0, y: 1.5)
        let br: ComplexNumber = ComplexNumber(x: 0.5, y: -1.25)
        let renderer: MandelbrotRenderer = MandelbrotRenderer(size: frameSize, topLeft: tl, bottomRight: br)
        let cgim: CGImage = renderer.getImage()
        let nsImage: NSImage = NSImage(CGImage: cgim, size: frameSize)
        imageView.image = nsImage
    }
}
