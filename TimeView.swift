//
//  GetTime.swift
//  RhythWalk
//
//  Created by 村上 惇 on 2014/11/12.
//  Copyright (c) 2014年 Jun Murakami. All rights reserved.
//

import Foundation
import UIKit

class TimeView{
    struct timeInfo{
        var year:Int = 0
        var month:Int = 0
        var day:Int = 0
        var hour:Int = 0
        var minute:Int = 0
        var second:Int = 0
    }
    
    var dates: timeInfo = timeInfo()
    
    func getTime() -> timeInfo{
        let date = NSDate()
        let calendar = NSCalendar(identifier: NSGregorianCalendar)
        //和暦を使いたいときはidentifierにはNSJapaneseCalendarを指定
        //let calendar = NSCalendar(identifier: NSJapaneseCalendar)

        var comps:NSDateComponents = calendar!.components(NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.MonthCalendarUnit|NSCalendarUnit.DayCalendarUnit|NSCalendarUnit.HourCalendarUnit|NSCalendarUnit.MinuteCalendarUnit|NSCalendarUnit.SecondCalendarUnit,
        fromDate: date)
        
        dates.year = comps.year
        dates.month = comps.month
        dates.day = comps.day
        dates.hour = comps.hour
        dates.minute = comps.minute
        dates.second = comps.second
        
        return dates
    }
    
    func season()-> String{
        if(dates.month == 1 || dates.month == 12 || dates.month == 2){
            return "winter"
        }
        else if(dates.month >= 3 && dates.month <= 5){
            return "supring"
        }
        else if(dates.month >= 6 && dates.month <= 8){
            return "summer"
        }
        else{
            return "autumn"
        }
    }
    
    func timeZone()->  String{
        var timeBasis: Int = dates.hour
        if(dates.minute >= 30) {timeBasis = timeBasis + 1}
        if(timeBasis == 24) {timeBasis == 0}
        
        if(timeBasis >= 0 && timeBasis <= 3) {return "mid night"}
        else if(timeBasis >= 4 && timeBasis <= 7) {return "early morning"}
        else if(timeBasis >= 8 && timeBasis <= 11) {return "morning"}
        else if(timeBasis >= 12 && timeBasis <= 15) {return "afternoon"}
        else if(timeBasis >= 16 && timeBasis <= 18) {return "evening"}
        else {return "night"}
    }
}