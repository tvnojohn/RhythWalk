//
//  GetWeather.swift
//  RhythWalk
//
//  Created by 三栖 惇 on 2014/11/20.
//  Copyright (c) 2014年 Jun Murakami. All rights reserved.
//

import Foundation

class GetWeather {
    
    var weatherObject: String
    var weatherID: Int
    init(){
        weatherObject = ""
        weatherID = 0
    }
    
    // API取得の開始処理
    func getAPIData() {
        let URL = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?lat=43.067885&lon=141.355539&mode=json&cnt=14&APPID=f7c8d5c740cd08b96df59d1775ef82ac")
        let req = NSURLRequest(URL: URL!)
        let connection: NSURLConnection = NSURLConnection(request: req, delegate: self, startImmediately: false)!
        var weather: String = ""
        
        // NSURLConnectionを使ってAPIを取得する
        NSURLConnection.sendAsynchronousRequest(req,
            queue: NSOperationQueue.mainQueue(),
            completionHandler: response)
    }
    
    // 取得したAPIデータの処理
    func response(res: NSURLResponse!, data: NSData!, error: NSError!) -> Void {
        
        let json:NSDictionary = NSJSONSerialization.JSONObjectWithData(data,
            options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
        
        let list: NSArray = json.objectForKey("list") as NSArray
        let weather: NSArray = list[0].objectForKey("weather") as NSArray
        weatherObject = weather[0].objectForKey("description") as String
        weatherID = weather[0].objectForKey("id") as Int
        println(weatherObject)
        println(weatherID)
    }
    
//    func getWeather() -> String {
//        getAPIData()
//        return weatherObject
//    }
    
//    func chooseWeather(){
//        let wObject: String = getWeather()
//        if(wObject.hasPrefix("")){}
//    }
    
    func chooseWeather2() -> String {
        getAPIData()
        var wObject: String = ""
        if(weatherID >= 200 && weatherID <= 550 /*|| weatherObject.hasSuffix("rain")*/){
            wObject = "Rainy"
        }else if(weatherID >= 600 && weatherID <= 650/* || weatherObject.hasSuffix("snow") || weatherObject.hasSuffix("sleet")*/){
            wObject = "Snowy"
        }else if(weatherID > 800 && weatherID <= 850 /*|| weatherObject.hasSuffix("clouds")*/){
            wObject = "Cloudy"
        }else if(weatherID == 800 /*|| weatherObject.hasSuffix("clear sky")*/){
            wObject = "Sunny"
        }else{
            wObject = "Snowny"
        }
        return wObject
    }
}