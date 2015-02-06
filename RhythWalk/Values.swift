//
//  Values.swift
//  RhythWalk
//
//  Created by 村上 惇 on 2014/11/14.
//  Copyright (c) 2014年 Jun Murakami. All rights reserved.
//

import Foundation

class Values{
    var BPMCheck:Bool = false
    var timeValue:Float = 0.5
    var placeValue:Float = 0.5
    var weatherValue:Float = 0.5
    var seasonValue:Float = 0.5
    var timeState:String? = "summer"
    var placeState:String? = "mountain"
    var weatherState:String? = "sunny"
    var seasonState:String? = "winter"
    var listString:String = "null"
    var listFlag:Bool = false
    
    
    func setBPM(check: Bool)-> Void{
        BPMCheck = check
    }
    
    func setTimeValue(val: Float)-> Void{
        timeValue = val
    }
    
    func setPlaceValue(val: Float)-> Void{
        placeValue = val
    }
    
    func setWeatherValue(val: Float)-> Void{
        weatherValue = val
    }
    
    func setSeasonValue(val: Float)-> Void{
        seasonValue = val
    }
    
    func setTimeState(val: String?)-> Void{
        timeState = val
    }
    
    func setPlaceState(val: String?)-> Void{
        placeState = val
    }
    
    func setWeatherState(val: String?)-> Void{
        weatherState = val
    }
    
    func setSeasonState(val: String?)-> Void{
        seasonState = val
    }
    
    func setListString(val: String?)-> Void{
        listString = val!
    }
    
    func setListFlag(val: Bool)->Void{
        listFlag = val
    }
}