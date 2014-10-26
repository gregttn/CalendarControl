//
//  NSCalendarExtension.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 26/10/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import Foundation

extension NSCalendar {
    func dayOfTheMonthFor(date: NSDate) -> Int {
        var components = self.components(NSCalendarUnit.DayCalendarUnit, fromDate: date)
        
        return components.day
    }
    
    func monthNameFor(date: NSDate) -> String {
        var components = self.components(NSCalendarUnit.MonthCalendarUnit, fromDate: date)
        
        return NSDateFormatter().monthSymbols[components.month-1] as String
    }
    
    func daysInMonthFor(date: NSDate) -> Int {
        return self.rangeOfUnit(NSCalendarUnit.DayCalendarUnit, inUnit: NSCalendarUnit.MonthCalendarUnit, forDate: date).length
    }
    
    func weekdayForFirstOfTheMonthFor(date: NSDate) -> Int {
        var dateComponents = self.components(NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit, fromDate: date)
        dateComponents.day = 1
        
        return self.component(NSCalendarUnit.WeekdayCalendarUnit, fromDate: self.dateFromComponents(dateComponents)!) - 1
    }
    
    func basicComponents(fromDate: NSDate) -> NSDateComponents {
        return self.components(NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit, fromDate: fromDate)
    }
}