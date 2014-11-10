//
//  NSDateExtension.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 09/11/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import Foundation

extension NSDate {
    func isSameDay(date: NSDate, calendar: NSCalendar) -> Bool {
        var selfComponents = calendar.components(NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.YearCalendarUnit, fromDate: self)
        var dateComponents = calendar.components(NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.YearCalendarUnit, fromDate: date)
        
        return dateComponents == selfComponents
    }
    
    func nextMonth(calendar: NSCalendar) -> NSDate {
        return plusMonths(1, calendar: calendar)
    }
    
    func previousMonth(calendar: NSCalendar) -> NSDate {
        return plusMonths(-1, calendar: calendar)
    }
    
    func plusMonths(months: Int, calendar: NSCalendar) -> NSDate {
        var dateComponents = NSDateComponents()
        dateComponents.month = months
        
        return calendar.dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions.allZeros)!
    }
}