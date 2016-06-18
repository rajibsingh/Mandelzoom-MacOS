//
//  ViewController.swift
//  Mandelzoom-MacOS
//
//  Created by Rajib Singh on 6/15/16.
//  Copyright © 2016 Sepoy Software. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // try to load up an image and display it
        let demoImage: NSImage = NSImage(imageLiteral: "eagle-strike.jpg")
        imageView.image = demoImage

        // now try to display a rendered bitmap
        let frameSize: CGSize = imageView.frame.size
        let tl: ComplexNumber = ComplexNumber(x: -2.0, y: 1.5)
        let br: ComplexNumber = ComplexNumber(x: 0.5, y: -1.25)
        let renderer: MandelbrotRenderer = MandelbrotRenderer(size: frameSize, topLeft: tl, bottomRight: br)
        let cgim: CGImage = renderer.getImage()
        let nsImage: NSImage = NSImage(CGImage: cgim, size: frameSize)
        imageView.image = nsImage
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

