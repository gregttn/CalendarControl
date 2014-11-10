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
    let calendar = NSCalendar.currentCalendar()
    
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
    
    func testNextMonth() {
        let date = dateFor(1, month:11, year: 2014)
        let nextMonth = date.nextMonth(calendar)
        
        let nextMonthComponents = calendar.basicComponents(nextMonth)
        
        XCTAssertEqual(nextMonthComponents.day, 1)
        XCTAssertEqual(nextMonthComponents.month, 12)
        XCTAssertEqual(nextMonthComponents.year, 2014)
    }
    
    func testNextMonthShouldRolloverToNextYear() {
        let date = dateFor(1, month:12, year: 2014)
        let nextMonth = date.nextMonth(calendar)
        
        let nextMonthComponents = calendar.basicComponents(nextMonth)
        
        XCTAssertEqual(nextMonthComponents.day, 1)
        XCTAssertEqual(nextMonthComponents.month, 1)
        XCTAssertEqual(nextMonthComponents.year, 2015)
    }

    func testPreviousMonth() {
        let date = dateFor(1, month:11, year: 2014)
        let previousMonth = date.previousMonth(calendar)
        
        let previousMonthComponents = calendar.basicComponents(previousMonth)
        
        XCTAssertEqual(previousMonthComponents.day, 1)
        XCTAssertEqual(previousMonthComponents.month, 10)
        XCTAssertEqual(previousMonthComponents.year, 2014)
    }
    
    func testPreviousMonthShouldRollbackToPreviousYear() {
        let date = dateFor(1, month:1, year: 2015)
        let previousMonth = date.previousMonth(calendar)
        
        let previousMonthComponents = calendar.basicComponents(previousMonth)
        
        XCTAssertEqual(previousMonthComponents.day, 1)
        XCTAssertEqual(previousMonthComponents.month, 12)
        XCTAssertEqual(previousMonthComponents.year, 2014)
    }
    
    private func dateFor(day: Int, month: Int, year: Int) -> NSDate {
        var dateComponents = NSDateComponents()
        dateComponents.calendar = calendar
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        
        return dateComponents.date!
    }
}