//
//  MalmuthHarville.swift
//  ICMCalculator
//
//  Created by Isaac Flaum on 4/22/16.
//  Copyright © 2016 iflaum. All rights reserved.
//

import XCTest
@testable import ICMCalculator

class MalmuthHarville: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // test the malmuth weitzman algorithm
    func mwAlgorithmTest() {
        let stacks = [1, 1, 2];
        let expectedP1s = [0.25, 0.25, 0.5];
        let expectedP2s = [0.33333333333333331, 0.33333333333333331, 0.33333333333333331];
        let mwAlgorithm = MWAlgorithm();
        let p1s = mwAlgorithm.pFirsts(stacks).filter{$0 != 0.0};
        let p2s = mwAlgorithm.pSeconds(stacks).filter{$0 != 0.0};
        XCTAssertEqual(expectedP1s, p1s);
        XCTAssertEqual(expectedP2s, p2s);
    }
    
}
