//
//  iOSComponentTests.swift
//  iOSComponentTests
//
//  Created by liyang on 16/4/15.
//  Copyright © 2016年 liyang. All rights reserved.
//

import XCTest
@testable import iOSComponent

class iOSComponentTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        var account = 3000
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            if account > 2000{
                sleep(2)
                account -= 2000
            }
            print("aaaa:\(account)")
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            if account > 2000{
                sleep(2)
                account -= 2000
            }
            print("aaaa:\(account)")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func tt(){
        var account = 3000
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            if account > 2000{
                sleep(2)
                account -= 2000
            }
            print("aaaa:\(account)")
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            if account > 2000{
                sleep(2)
                account -= 2000
            }
            print("aaaa:\(account)")
        }
    }

    
    func test1(){
        var account = 3000
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            if account > 2000{
                sleep(2)
                account -= 2000
            }
            print("aaaa:\(account)")
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            if account > 2000{
                sleep(2)
                account -= 2000
            }
            print("aaaa:\(account)")
        }
    }
}
