//
//  ViewController.swift
//  Mandelzoom-MacOS
//
//  Created by Rajib Singh on 6/15/16.
//  Copyright © 2016 Sepoy Software. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var mandelView: MandelView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mandelView.initRender()
    }

}

