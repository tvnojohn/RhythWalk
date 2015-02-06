//
//  Parameters.swift
//  RhythWalk
//
//  Created by 三栖 惇 on 2014/11/12.
//  Copyright (c) 2014年 Jun Murakami. All rights reserved.
//

import Foundation
import MediaPlayer

class Parameters {
    init(){
        
    }
    
    func analyzeLyrics(lyrics: MPMediaItem) -> Void {
        
    }
    
    func getWeather(lyrycs: MPMediaItem) -> NSDictionary {
        analyzeLyrics(lyrycs)
        let weather: NSDictionary = [
            "Sunny" :  0,
            "Rainy" :  0,
            "Cloudy":  0,
            "Snowy" :  0
        ]
        
        
        
        
        return weather
    }
}