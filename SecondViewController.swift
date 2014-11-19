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
    var nowTime:TimeView = TimeView()
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    var onOff:String = "off"
    var bpmLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nowTime.getTime()
        // 設定終了ボタン
        let setFinButton   = UIButton()
        setFinButton.tag = 4
        setFinButton.frame = CGRectMake(0, 0, 75, 75)
        setFinButton.layer.position = CGPoint(x:self.view.frame.width-30, y:self.view.frame.height-50)
        setFinButton.setImage(UIImage(named: "矢印.png") as UIImage, forState: .Normal)
        setFinButton.addTarget(self, action: "setFin:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(setFinButton)
        
        //Timeラベル
        let timeLabel: UILabel = UILabel(frame: CGRectMake(0, 0, 200, 22))
        //timeLabel.text = "Night"
        timeLabel.alignmentRectInsets()
        timeLabel.text = "Time:\(nowTime.timeZone())"
        timeLabel.textAlignment = .Center
        timeLabel.textColor = UIColor.redColor()
        timeLabel.shadowColor = UIColor.clearColor()
        timeLabel.layer.position = CGPoint(x: self.view.bounds.width/2 ,y: 161)
        self.view.addSubview(timeLabel)
        
        //timeSliderを作成
        let timeSlider = UISlider(frame: CGRectMake(0, 0, 270, 30))
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
        
        //weatherラベル
        let weatherLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,22))
        //weatherLabel.text = "Sunny"
        weatherLabel.text = "Weather"
        weatherLabel.textAlignment = .Center
        weatherLabel.textColor = UIColor.purpleColor()
        weatherLabel.shadowColor = UIColor.clearColor()
        weatherLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 251)
        self.view.addSubview(weatherLabel)
        
        //weatherSliderを作成
        let weatherSlider = UISlider(frame: CGRectMake(0, 0, 270, 30))
        
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
        
        //placeラベル
        let placeLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,22))
        placeLabel.text = "Place"
        //placeLabel.text = "Sea"
        placeLabel.textAlignment = .Center
        placeLabel.textColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        placeLabel.shadowColor = UIColor.clearColor()
        placeLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 341)
        self.view.addSubview(placeLabel)
        
        //placeSliderを作成
        let placeSlider = UISlider(frame: CGRectMake(0, 0, 270, 30))
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
        
        //seasonラベル
        let seasonLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,22))
        //seasonLabel.text = "Summer"
        seasonLabel.text = "Season:\(nowTime.season())"
        seasonLabel.textAlignment = .Center
        seasonLabel.textColor = UIColor.blueColor()
        seasonLabel.shadowColor = UIColor.clearColor()
        seasonLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 436)
        self.view.addSubview(seasonLabel)
        
        //seasonSliderを作成
        let seasonSlider = UISlider(frame: CGRectMake(0, 0, 270, 30))
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
            self.view.backgroundColor = UIColor.blackColor()
            bpmSwicth.tintColor = UIColor.whiteColor()
        }
        
        
    }
    
    func setFin(sender: UIButton){
        // アニメーションを設定する.
        //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
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
    
    func bpmClickMySwicth(sender: UISwitch){
        appDelegate.mySituation.setBPM(sender.on)
        if(appDelegate.mySituation.BPMCheck == true){ onOff = "ON" }
        else{ onOff = "OFF"}
        bpmLabel.text = "BPM:\(onOff)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}