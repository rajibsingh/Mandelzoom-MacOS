//
//  Mandelzoom_MacOSTests.swift
//  Mandelzoom-MacOSTests
//
//  Created by Rajib Singh on 6/15/16.
//  Copyright © 2016 Sepoy Software. All rights reserved.
//

import XCTest
@testable import Mandelzoom_MacOS

class Mandelzoom_MacOSTests: XCTestCase {

    fileprivate var tl: ComplexNumber = ComplexNumber(x: -1.0, y: 0.75)
    fileprivate var br: ComplexNumber = ComplexNumber(x: 0.5, y: -1)

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the codenow  you want to measure the time of here.
            let cgsize: CGSize = CGSize(width: 1000, height: 1000)
            let renderer: MandelbrotRenderer = MandelbrotRenderer(size: cgsize, topLeft: self.tl, bottomRight: self.br)
            let image = renderer.getImage()
        }
    }
    
}
