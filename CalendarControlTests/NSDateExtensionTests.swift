//
//  NSDateExtensionTests.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 09/11/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import Foundation
import XCTest

class NSDateExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsSameDay() {
        var today = NSDate()
        
        XCTAssertTrue(today.isSameDay(NSDate(), calendar: NSCalendar.currentCalendar()))
    }
    
    func testIsSameDayWithTwoDifferentDays() {
        var today = NSDate()
        
        XCTAssertFalse(today.isSameDay(NSDate(timeIntervalSince1970:1000), calendar: NSCalendar.currentCalendar()))
    }
    
    func testIsSameDayWithSameDaysButDifferentHours() {
        var today = NSDate()

        var todayAtNine = NSCalendar.currentCalendar().components(NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.HourCalendarUnit, fromDate: today)
        todayAtNine.calendar = NSCalendar.currentCalendar()
        todayAtNine.hour = 9
        
        XCTAssertTrue(today.isSameDay(todayAtNine.date!, calendar: NSCalendar.currentCalendar()))
    }
}