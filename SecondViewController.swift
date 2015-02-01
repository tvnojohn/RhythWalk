//
//  SettingViewController.swift
//  RhythWalk
//
//  Created by 村上 惇 on 2014/10/24.
//  Copyright (c) 2014年 Jun Murakami. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    /*--------------------------- 初期値設定 ---------------------------*/
    var nowTime:TimeView = TimeView()
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    var onOff:String = "off"
    var bpmLabel:UILabel!
    var debugFlag:Bool = true
    
    var timeLabel: UILabel = UILabel()
    var weatherLabel: UILabel = UILabel()
    var placeLabel: UILabel = UILabel()
    var seasonLabel: UILabel = UILabel()
    
    var timeSlider:UISlider = UISlider()
    var weatherSlider:UISlider = UISlider()
    var placeSlider:UISlider = UISlider()
    var seasonSlider:UISlider = UISlider()
    
    let debugMorningButton = UIButton()
    let debugNoonButton = UIButton()
    let debugEveningButton = UIButton()
    let debugNightButton = UIButton()
    
    let debugSunnyButton = UIButton()
    let debugCloudyButton = UIButton()
    let debugSnowyButton = UIButton()
    let debugRainyButton = UIButton()
    
    let debugSeaButton = UIButton()
    let debugMountainButton = UIButton()
    let debugCityButton = UIButton()
    
    let debugSpringButton = UIButton()
    let debugSummerButton = UIButton()
    let debugAutumnButton = UIButton()
    let debugWinterButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nowTime.getTime()
        /*-------------------------- 設定終了ボタン ----------------------------------*/
        let setFinButton   = UIButton()
        setFinButton.tag = 4
        setFinButton.frame = CGRectMake(0, 0, 75, 75)
        setFinButton.layer.position = CGPoint(x:self.view.frame.width-30, y:self.view.frame.height-50)
        setFinButton.setImage(UIImage(named: "矢印.png") as UIImage!, forState: .Normal)
        setFinButton.addTarget(self, action: "setFin:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(setFinButton)
        
        
        /*--------------------------- time設定 ---------------------------*/
        //Timeラベル
        timeLabel = UILabel(frame: CGRectMake(0, 0, 200, 22))
        //timeLabel.text = "Night"
        timeLabel.alignmentRectInsets()
        timeLabel.text = nowTime.timeZone()
        appDelegate.mySituation.setTimeState(nowTime.timeZone())
        timeLabel.textAlignment = .Center
        timeLabel.textColor = UIColor.redColor()
        timeLabel.shadowColor = UIColor.clearColor()
        timeLabel.layer.position = CGPoint(x: self.view.bounds.width/2 ,y: 161)
        self.view.addSubview(timeLabel)
        
        //timeSliderを作成
        timeSlider = UISlider(frame: CGRectMake(0, 0, 270, 30))
        timeSlider.layer.position = CGPointMake(self.view.frame.width/2, 195)
        timeSlider.backgroundColor = UIColor.clearColor()
        timeSlider.layer.cornerRadius = 0.0
        timeSlider.layer.shadowOpacity = 0.0
        timeSlider.layer.masksToBounds = false
        timeSlider.minimumTrackTintColor = UIColor.redColor()
        
        // 最小値と最大値を設定する.
        timeSlider.minimumValue = 0
        timeSlider.maximumValue = 1
        
        // Sliderの位置を設定する.
        timeSlider.value = appDelegate.mySituation.timeValue
        timeSlider.addTarget(self, action: "timeSlider:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(timeSlider)
        
        
        /*--------------------------- weather設定 ---------------------------*/
        //weatherラベル
        weatherLabel = UILabel(frame: CGRectMake(0,0,200,22))
        //weatherLabel.text = "Sunny"
        weatherLabel.text = appDelegate.mySituation.weatherState
        weatherLabel.textAlignment = .Center
        weatherLabel.textColor = UIColor.purpleColor()
        weatherLabel.shadowColor = UIColor.clearColor()
        weatherLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 251)
        self.view.addSubview(weatherLabel)
        
        //weatherSliderを作成
        weatherSlider = UISlider(frame: CGRectMake(0, 0, 270, 30))
        
        weatherSlider.layer.position = CGPointMake(self.view.frame.width/2, 285)
        weatherSlider.backgroundColor = UIColor.clearColor()
        weatherSlider.layer.cornerRadius = 0.0
        weatherSlider.layer.shadowOpacity = 0.0
        weatherSlider.layer.masksToBounds = false
        weatherSlider.minimumTrackTintColor = UIColor.purpleColor()
        // 最小値と最大値を設定する.
        weatherSlider.minimumValue = 0
        weatherSlider.maximumValue = 1
        
        // Sliderの位置を設定する.
        weatherSlider.value = appDelegate.mySituation.weatherValue
        weatherSlider.addTarget(self, action: "weatherSlider:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(weatherSlider)
        
        
        /*--------------------------- place設定 ---------------------------*/
        //placeラベル
        placeLabel = UILabel(frame: CGRectMake(0,0,200,22))
        placeLabel.text = appDelegate.mySituation.placeState
        placeLabel.textAlignment = .Center
        placeLabel.textColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        placeLabel.shadowColor = UIColor.clearColor()
        placeLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 341)
        self.view.addSubview(placeLabel)
        
        //placeSliderを作成
        placeSlider = UISlider(frame: CGRectMake(0, 0, 270, 30))
        placeSlider.layer.position = CGPointMake(self.view.frame.width/2, 375)
        placeSlider.backgroundColor = UIColor.clearColor()
        placeSlider.layer.cornerRadius = 0.0
        placeSlider.layer.shadowOpacity = 0.0
        placeSlider.layer.masksToBounds = false
        placeSlider.minimumTrackTintColor = UIColor.greenColor()
        
        // 最小値と最大値を設定する.
        placeSlider.minimumValue = 0
        placeSlider.maximumValue = 1
        
        // Sliderの位置を設定する.
        placeSlider.value = appDelegate.mySituation.placeValue
        placeSlider.addTarget(self, action: "placeSlider:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(placeSlider)
        
        
        /*--------------------------- season設定 ---------------------------*/
        //seasonラベル
        seasonLabel = UILabel(frame: CGRectMake(0,0,200,22))
        //seasonLabel.text = "Summer"
        seasonLabel.text = nowTime.season()
        appDelegate.mySituation.setSeasonState(nowTime.season())
        seasonLabel.textAlignment = .Center
        seasonLabel.textColor = UIColor.blueColor()
        seasonLabel.shadowColor = UIColor.clearColor()
        seasonLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 436)
        self.view.addSubview(seasonLabel)
        
        //seasonSliderを作成
        seasonSlider = UISlider(frame: CGRectMake(0, 0, 270, 30))
        seasonSlider.layer.position = CGPointMake(self.view.frame.width/2, 465)
        seasonSlider.backgroundColor = UIColor.clearColor()
        seasonSlider.layer.cornerRadius = 0.0
        seasonSlider.layer.shadowOpacity = 0.0
        seasonSlider.layer.masksToBounds = false
        seasonSlider.minimumTrackTintColor = UIColor.blueColor()
        
        // 最小値と最大値を設定する.
        seasonSlider.minimumValue = 0
        seasonSlider.maximumValue = 1
        
        // Sliderの位置を設定する.
        seasonSlider.value = appDelegate.mySituation.seasonValue
        
        // ラベルをviewに追加
        seasonSlider.addTarget(self, action: "seasonSlider:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(seasonSlider)
        
        
        /*--------------------------- BPM設定 ---------------------------*/
        //bpmラベル
        bpmLabel = UILabel(frame: CGRectMake(0,0,200,22))
        if(appDelegate.mySituation.BPMCheck == true){ onOff = "ON" }
        else{ onOff = "OFF"}
        bpmLabel.text = "BPM:\(onOff)"
        bpmLabel.textAlignment = .Center
        bpmLabel.textColor = UIColor(red: 1, green: 0.5, blue: 0, alpha: 1)
        bpmLabel.shadowColor = UIColor.clearColor()
        bpmLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 70)
        self.view.addSubview(bpmLabel)
        
        // bpmのon.offボタンを作成
        let bpmSwicth: UISwitch = UISwitch()
        bpmSwicth.layer.position = CGPoint(x: self.view.frame.width/2, y: 100)
        bpmSwicth.on = appDelegate.mySituation.BPMCheck
        bpmSwicth.onTintColor = UIColor(red: 1, green: 0.5, blue: 0, alpha: 1)
        bpmSwicth.addTarget(self, action: "bpmClickMySwicth:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(bpmSwicth)
        
        if(nowTime.getTime().hour>=4 && nowTime.getTime().hour <= 18){
            self.view.backgroundColor = UIColor.whiteColor()
            bpmSwicth.tintColor = UIColor.blackColor()
        }else{
            self.view.backgroundColor = UIColor.whiteColor()
            //self.view.backgroundColor = UIColor.blackColor()
            bpmSwicth.tintColor = UIColor.whiteColor()
        }
        
        
        /*------------------------debug------------------------------------------------*/
        // デバックボタン
        let debugButton   = UIButton()
        debugButton.tag = 4
        debugButton.frame = CGRectMake(0, 0, 60, 50)
        debugButton.layer.position = CGPoint(x:25, y:self.view.frame.height-50)
        debugButton.backgroundColor = UIColor.blackColor()
        debugButton.setTitle("demo", forState: .Normal)
        debugButton.addTarget(self, action: "debug:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(debugButton)
        
        // デバック朝ボタン
        debugMorningButton.tag = 4
        debugMorningButton.frame = CGRectMake(0, 0, 75, 50)
        debugMorningButton.layer.position = CGPoint(x:94, y:self.view.frame.height-50)
        debugMorningButton.backgroundColor = UIColor.blackColor()
        debugMorningButton.setTitle("morning", forState: .Normal)
        debugMorningButton.addTarget(self, action: "debugTime:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugMorningButton)
        
        // デバック昼ボタン
        debugNoonButton.tag = 4
        debugNoonButton.frame = CGRectMake(0, 0, 75, 50)
        debugNoonButton.layer.position = CGPoint(x:94, y:self.view.frame.height-101)
        debugNoonButton.backgroundColor = UIColor.blackColor()
        debugNoonButton.setTitle("afternoon", forState: .Normal)
        debugNoonButton.addTarget(self, action: "debugTime:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugNoonButton)

        // デバック夕方ボタン
        debugEveningButton.tag = 4
        debugEveningButton.frame = CGRectMake(0, 0, 75, 50)
        debugEveningButton.layer.position = CGPoint(x:94, y:self.view.frame.height-152)
        debugEveningButton.backgroundColor = UIColor.blackColor()
        debugEveningButton.setTitle("evening", forState: .Normal)
        debugEveningButton.addTarget(self, action: "debugTime:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugEveningButton)

        // デバック夜ボタン
        debugNightButton.tag = 4
        debugNightButton.frame = CGRectMake(0, 0, 75, 50)
        debugNightButton.layer.position = CGPoint(x:94, y:self.view.frame.height-203)
        debugNightButton.backgroundColor = UIColor.blackColor()
        debugNightButton.setTitle("night", forState: .Normal)
        debugNightButton.addTarget(self, action: "debugTime:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugNightButton)
        
        // デバック晴れボタン
        debugSunnyButton.tag = 4
        debugSunnyButton.frame = CGRectMake(0, 0, 60, 50)
        debugSunnyButton.layer.position = CGPoint(x:162, y:self.view.frame.height-50)
        debugSunnyButton.backgroundColor = UIColor.blackColor()
        debugSunnyButton.setTitle("sunny", forState: .Normal)
        debugSunnyButton.addTarget(self, action: "debugWeather:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugSunnyButton)
        
        // デバック雲りボタン
        debugCloudyButton.tag = 4
        debugCloudyButton.frame = CGRectMake(0, 0, 60, 50)
        debugCloudyButton.layer.position = CGPoint(x:162, y:self.view.frame.height-101)
        debugCloudyButton.backgroundColor = UIColor.blackColor()
        debugCloudyButton.setTitle("cloudy", forState: .Normal)
        debugCloudyButton.addTarget(self, action: "debugWeather:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugCloudyButton)
        
        // デバック雪ボタン
        debugSnowyButton.tag = 4
        debugSnowyButton.frame = CGRectMake(0, 0, 60, 50)
        debugSnowyButton.layer.position = CGPoint(x:162, y:self.view.frame.height-152)
        debugSnowyButton.backgroundColor = UIColor.blackColor()
        debugSnowyButton.setTitle("snowy", forState: .Normal)
        debugSnowyButton.addTarget(self, action: "debugWeather:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugSnowyButton)
        
        // デバック雨ボタン
        debugRainyButton.tag = 4
        debugRainyButton.frame = CGRectMake(0, 0, 60, 50)
        debugRainyButton.layer.position = CGPoint(x:162, y:self.view.frame.height-203)
        debugRainyButton.backgroundColor = UIColor.blackColor()
        debugRainyButton.setTitle("rainy", forState: .Normal)
        debugRainyButton.addTarget(self, action: "debugWeather:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugRainyButton)
        
        // デバック海ボタン
        debugSeaButton.tag = 4
        debugSeaButton.frame = CGRectMake(0, 0, 50, 50)
        debugSeaButton.layer.position = CGPoint(x:218, y:self.view.frame.height-50)
        debugSeaButton.backgroundColor = UIColor.blackColor()
        debugSeaButton.setTitle("sea", forState: .Normal)
        debugSeaButton.addTarget(self, action: "debugPlace:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugSeaButton)
        
        // デバック山ボタン
        debugMountainButton.tag = 4
        debugMountainButton.frame = CGRectMake(0, 0, 50, 50)
        debugMountainButton.layer.position = CGPoint(x:218, y:self.view.frame.height-101)
        debugMountainButton.backgroundColor = UIColor.blackColor()
        debugMountainButton.setTitle("mountain", forState: .Normal)
        debugMountainButton.addTarget(self, action: "debugPlace:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugMountainButton)
        
        // デバック町ボタン
        debugCityButton.tag = 4
        debugCityButton.frame = CGRectMake(0, 0, 50, 50)
        debugCityButton.layer.position = CGPoint(x:218, y:self.view.frame.height-152)
        debugCityButton.backgroundColor = UIColor.blackColor()
        debugCityButton.setTitle("city", forState: .Normal)
        debugCityButton.addTarget(self, action: "debugPlace:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugCityButton)
        
        // デバック春ボタン
        debugSpringButton.tag = 4
        debugSpringButton.frame = CGRectMake(0, 0, 70, 50)
        debugSpringButton.layer.position = CGPoint(x:280, y:self.view.frame.height-50)
        debugSpringButton.backgroundColor = UIColor.blackColor()
        debugSpringButton.setTitle("spring", forState: .Normal)
        debugSpringButton.addTarget(self, action: "debugSeason:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugSpringButton)

        // デバック夏ボタン
        debugSummerButton.tag = 4
        debugSummerButton.frame = CGRectMake(0, 0, 70, 50)
        debugSummerButton.layer.position = CGPoint(x:280, y:self.view.frame.height-101)
        debugSummerButton.backgroundColor = UIColor.blackColor()
        debugSummerButton.setTitle("summer", forState: .Normal)
        debugSummerButton.addTarget(self, action: "debugSeason:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugSummerButton)

        // デバック秋ボタン
        debugAutumnButton.tag = 4
        debugAutumnButton.frame = CGRectMake(0, 0, 70, 50)
        debugAutumnButton.layer.position = CGPoint(x:280, y:self.view.frame.height-152)
        debugAutumnButton.backgroundColor = UIColor.blackColor()
        debugAutumnButton.setTitle("fall", forState: .Normal)
        debugAutumnButton.addTarget(self, action: "debugSeason:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugAutumnButton)

        // デバック冬ボタン
        debugWinterButton.tag = 4
        debugWinterButton.frame = CGRectMake(0, 0, 70, 50)
        debugWinterButton.layer.position = CGPoint(x:280, y:self.view.frame.height-203)
        debugWinterButton.backgroundColor = UIColor.blackColor()
        debugWinterButton.setTitle("winter", forState: .Normal)
        debugWinterButton.addTarget(self, action: "debugSeason:", forControlEvents:.TouchUpInside)
        self.view.addSubview(debugWinterButton)

        debugButtonOn()
    }
    
    /*--------------------------- 設定画面終了 ---------------------------*/
    func setFin(sender: UIButton){
        // アニメーションを設定する.
        //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        println(appDelegate.mySituation.placeState)
        
        // Viewの移動する.
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*--------------------------- sliderの値保存 ---------------------------*/
    func timeSlider(sender : UISlider){
        appDelegate.mySituation.setTimeValue(sender.value)
    }
    
    func weatherSlider(sender : UISlider){
        appDelegate.mySituation.setWeatherValue(sender.value)
    }
    
    func placeSlider(sender : UISlider){
        appDelegate.mySituation.setPlaceValue(sender.value)
    }
    
    func seasonSlider(sender : UISlider){
        appDelegate.mySituation.setSeasonValue(sender.value)
    }
    
    
    /*--------------------------- bpmONOFF設定 ---------------------------*/
    func bpmClickMySwicth(sender: UISwitch){
        appDelegate.mySituation.setBPM(sender.on)
        if(appDelegate.mySituation.BPMCheck == true){ onOff = "ON" }
        else{ onOff = "OFF"}
        bpmLabel.text = "BPM:\(onOff)"
    }
    
    
    /*--------------------------- debugモード ---------------------------*/
    func debug(sender: UIButton){
        debugButtonOn()
        if(appDelegate.mySituation.listFlag == false){
            appDelegate.mySituation.setListFlag(true)
        }else{
            appDelegate.mySituation.setListFlag(false)
        }
    }
    func debugButtonOn(){
        if(debugFlag == false){
            debugMorningButton.hidden = false
            debugNoonButton.hidden = false
            debugEveningButton.hidden = false
            debugNightButton.hidden = false
            
            debugSunnyButton.hidden = false
            debugCloudyButton.hidden = false
            debugSnowyButton.hidden = false
            debugRainyButton.hidden = false
            
            debugSeaButton.hidden = false
            debugMountainButton.hidden = false
            debugCityButton.hidden = false
            
            debugSpringButton.hidden = false
            debugSummerButton.hidden = false
            debugAutumnButton.hidden = false
            debugWinterButton.hidden = false
            
            debugFlag = true
        }else{
            debugMorningButton.hidden = true
            debugNoonButton.hidden = true
            debugEveningButton.hidden = true
            debugNightButton.hidden = true
            
            debugSunnyButton.hidden = true
            debugCloudyButton.hidden = true
            debugSnowyButton.hidden = true
            debugRainyButton.hidden = true
            
            debugSeaButton.hidden = true
            debugMountainButton.hidden = true
            debugCityButton.hidden = true
            
            debugSpringButton.hidden = true
            debugSummerButton.hidden = true
            debugAutumnButton.hidden = true
            debugWinterButton.hidden = true
            
            debugFlag = false
        }
    }
    
    func debugTime(sender: UIButton){
        timeSlider.value = 1
        weatherSlider.value = 0
        placeSlider.value = 0
        seasonSlider.value = 0
        appDelegate.mySituation.setTimeValue(1)
        appDelegate.mySituation.setPlaceValue(0)
        appDelegate.mySituation.setSeasonValue(0)
        appDelegate.mySituation.setWeatherValue(0)
        timeLabel.text = sender.titleLabel?.text
        appDelegate.mySituation.setTimeState(timeLabel.text!)
        debugButtonOn()
        appDelegate.mySituation.setListString("time")
    }

    func debugWeather(sender: UIButton){
        timeSlider.value = 0
        weatherSlider.value = 1
        placeSlider.value = 0
        seasonSlider.value = 0
        appDelegate.mySituation.setTimeValue(0)
        appDelegate.mySituation.setPlaceValue(0)
        appDelegate.mySituation.setSeasonValue(0)
        appDelegate.mySituation.setWeatherValue(1)
        let text:String? = sender.titleLabel?.text
        //weatherLabel.text = text + sender.titleLabel?.text
        weatherLabel.text = sender.titleLabel?.text
        appDelegate.mySituation.setWeatherState(weatherLabel.text)
        debugButtonOn()
        appDelegate.mySituation.setListString("weather")
    }
    
    func debugPlace(sender: UIButton){
        timeSlider.value = 0
        weatherSlider.value = 0
        placeSlider.value = 1
        seasonSlider.value = 0
        appDelegate.mySituation.setTimeValue(0)
        appDelegate.mySituation.setPlaceValue(1)
        appDelegate.mySituation.setSeasonValue(0)
        appDelegate.mySituation.setWeatherValue(0)
        placeLabel.text = sender.titleLabel?.text
        appDelegate.mySituation.setPlaceState(placeLabel.text)
        debugButtonOn()
    }
    
    func debugSeason(sender: UIButton){
        timeSlider.value = 0
        weatherSlider.value = 0
        placeSlider.value = 0
        seasonSlider.value = 1
        appDelegate.mySituation.setTimeValue(0)
        appDelegate.mySituation.setPlaceValue(0)
        appDelegate.mySituation.setSeasonValue(1)
        appDelegate.mySituation.setWeatherValue(0)
        seasonLabel.text = sender.titleLabel?.text
        appDelegate.mySituation.setSeasonState(seasonLabel.text)
        debugButtonOn()
        appDelegate.mySituation.setListString("season")
    }
    
    /*--------------------------- メモリ解放 ---------------------------*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}