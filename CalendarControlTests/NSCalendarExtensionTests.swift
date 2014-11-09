//
//  NSCalendarExtensionTests.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 09/11/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import Foundation
import XCTest

class NSCalendarExtensionTests: XCTestCase {
    private let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDayOfTheMonth() {
        var dateComponents = dateComponentsFor(10, month:8, year:2013)
        
        XCTAssertEqual(calendar!.dayOfTheMonthFor(dateComponents.date!), 10)
    }
    
    func testDaysInMonthForDate() {
        var dateComponents = dateComponentsFor(9, month:11, year:2014)
        
        XCTAssertEqual(calendar!.daysInMonthFor(dateComponents.date!), 30)
    }
    
    func testDaysInMonthForLeapYear() {
        var dateComponents = dateComponentsFor(29, month:2, year:2016)
        
        XCTAssertEqual(calendar!.daysInMonthFor(dateComponents.date!), 29)
    }
    
    func testMonthNameForDate() {
        var dateComponents = dateComponentsFor(1, month:8, year:2014)
        
        XCTAssertEqual(calendar!.monthNameFor(dateComponents.date!), "August")
    }
    
    func testWeekdayForFirstOfTheMonthForDate() {
        var dateComponents = dateComponentsFor(10, month:12, year:2014)
        
        XCTAssertEqual(calendar!.weekdayForFirstOfTheMonthFor(dateComponents.date!), 1)
    }
    
    func testWeekdayForFirstOfTheMonthForDate2() {
        var dateComponents = dateComponentsFor(10, month:11, year:2014)
        
        XCTAssertEqual(calendar!.weekdayForFirstOfTheMonthFor(dateComponents.date!), 6)
    }
    
    private func dateComponentsFor(day: Int, month: Int, year: Int) -> NSDateComponents {
        var dateComponents = NSDateComponents()
        dateComponents.calendar = calendar
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        
        return dateComponents
    }
}