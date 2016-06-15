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

        // Do any additional setup after loading the view.
        print(imageView.description)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

