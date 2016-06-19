//
// Created by Rajib Singh on 6/18/16.
// Copyright (c) 2016 Sepoy Software. All rights reserved.
//

import Foundation
import Cocoa

class MandelView: NSView {

    private var startBox: NSPoint?
    private var endBox: NSPoint?

    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func mouseDown(event: NSEvent) {
        NSLog("mouseDown event registered")
        var location = event.locationInWindow
        var local_point = convertPoint(location, fromView: self)
        NSLog("\tlocation:\(local_point.x), \(local_point.y)")
    }

//    override func mouseDragged(theEvent: NSEvent) {
//        NSLog("mouseDragged event registered")
//    }

    override func mouseUp(event: NSEvent) {
        NSLog("mouseUp event registered")
        var location = event.locationInWindow
        var local_point = convertPoint(location, fromView: self)
        NSLog("\tlocation:\(local_point.x), \(local_point.y)")
    }

    override func mouseMoved(theEvent: NSEvent) {
        NSLog("mouseDown event registered")
    }

    func acceptsFirstMouseEvent(theEvent: NSEvent) -> Bool {
        return true
    }
}
