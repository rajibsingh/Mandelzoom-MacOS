//
// Created by Rajib Singh on 6/18/16.
// Copyright (c) 2016 Sepoy Software. All rights reserved.
//

import Foundation
import Cocoa

class MandelView: NSView {

    override func mouseUp(theEvent: NSEvent) {
        print("mouseUp event registered")
    }

    override func mouseDragged(theEvent: NSEvent) {
        print("mouseDragged event registered")
    }

    override func mouseDown(theEvent: NSEvent) {
        print("mouseDown event registered")
    }

    override func mouseMoved(theEvent: NSEvent) {
        print("mouseDown event registered")
    }

    func acceptsFirstMouseEvent(theEvent: NSEvent) -> Bool {
        return true
    }
}
