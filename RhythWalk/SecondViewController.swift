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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        // 設定終了ボタン
        let setFinButton   = UIButton()
        setFinButton.tag = 4
        setFinButton.frame = CGRectMake(0, 0, 75, 75)
        setFinButton.layer.position = CGPoint(x:self.view.frame.width-30, y:self.view.frame.height-50)
        setFinButton.setImage(UIImage(named: "矢印.png") as UIImage, forState: .Normal)
        setFinButton.addTarget(self, action: "setFin:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(setFinButton)
        
        //Timeラベル
        let timeLabel: UILabel = UILabel(frame: CGRectMake(0,0,39,22))
        timeLabel.text = "Time"
        timeLabel.textColor = UIColor.redColor()
        timeLabel.shadowColor = UIColor.whiteColor()
        timeLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 161)
        self.view.addSubview(timeLabel)
        
        //timeSliderを作成
        let timeSlider = UISlider(frame: CGRectMake(0, 0, 270, 30))
        timeSlider.layer.position = CGPointMake(self.view.frame.width/2, 195)
        timeSlider.backgroundColor = UIColor.whiteColor()
        timeSlider.layer.cornerRadius = 0.0
        timeSlider.layer.shadowOpacity = 0.0
        timeSlider.layer.masksToBounds = false
        timeSlider.minimumTrackTintColor = UIColor.redColor()
        
        // 最小値と最大値を設定する.
        timeSlider.minimumValue = 0
        timeSlider.maximumValue = 1
        
        // Sliderの位置を設定する.
        timeSlider.value = 0.5
        timeSlider.addTarget(self, action: "timeSlider:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(timeSlider)
        
        //weatherラベル
        let weatherLabel: UILabel = UILabel(frame: CGRectMake(0,0,65,22))
        weatherLabel.text = "Weather"
        weatherLabel.textColor = UIColor.purpleColor()
        weatherLabel.shadowColor = UIColor.whiteColor()
        weatherLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 251)
        self.view.addSubview(weatherLabel)
        
        //weatherSliderを作成
        let weatherSlider = UISlider(frame: CGRectMake(0, 0, 270, 30))
        
        weatherSlider.layer.position = CGPointMake(self.view.frame.width/2, 285)
        weatherSlider.backgroundColor = UIColor.whiteColor()
        weatherSlider.layer.cornerRadius = 0.0
        weatherSlider.layer.shadowOpacity = 0.0
        weatherSlider.layer.masksToBounds = false
        weatherSlider.minimumTrackTintColor = UIColor.purpleColor()
        // 最小値と最大値を設定する.
        weatherSlider.minimumValue = 0
        weatherSlider.maximumValue = 1
        
        // Sliderの位置を設定する.
        weatherSlider.value = 0.5
        weatherSlider.addTarget(self, action: "weatherSlider:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(weatherSlider)
        
        //placeラベル
        let placeLabel: UILabel = UILabel(frame: CGRectMake(0,0,44,22))
        placeLabel.text = "Place"
        placeLabel.textColor = UIColor.greenColor()
        placeLabel.shadowColor = UIColor.whiteColor()
        placeLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 341)
        self.view.addSubview(placeLabel)
        
        //placeSliderを作成
        let placeSlider = UISlider(frame: CGRectMake(0, 0, 270, 30))
        placeSlider.layer.position = CGPointMake(self.view.frame.width/2, 375)
        placeSlider.backgroundColor = UIColor.whiteColor()
        placeSlider.layer.cornerRadius = 0.0
        placeSlider.layer.shadowOpacity = 0.0
        placeSlider.layer.masksToBounds = false
        placeSlider.minimumTrackTintColor = UIColor.greenColor()
        
        // 最小値と最大値を設定する.
        placeSlider.minimumValue = 0
        placeSlider.maximumValue = 1
        
        // Sliderの位置を設定する.
        placeSlider.value = 0.5
        placeSlider.addTarget(self, action: "placeSlider:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(placeSlider)
        
        //seasonラベル
        let seasonLabel: UILabel = UILabel(frame: CGRectMake(0,0,59,22))
        seasonLabel.text = "Season"
        seasonLabel.textColor = UIColor.blueColor()
        seasonLabel.shadowColor = UIColor.whiteColor()
        seasonLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 436)
        self.view.addSubview(seasonLabel)
        
        //seasonSliderを作成
        let seasonSlider = UISlider(frame: CGRectMake(0, 0, 270, 30))
        seasonSlider.layer.position = CGPointMake(self.view.frame.width/2, 465)
        seasonSlider.backgroundColor = UIColor.whiteColor()
        seasonSlider.layer.cornerRadius = 0.0
        seasonSlider.layer.shadowOpacity = 0.0
        seasonSlider.layer.masksToBounds = false
        seasonSlider.minimumTrackTintColor = UIColor.blueColor()
        
        // 最小値と最大値を設定する.
        seasonSlider.minimumValue = 0
        seasonSlider.maximumValue = 1
        
        // Sliderの位置を設定する.
        seasonSlider.value = 0.5
        
        // ラベルをviewに追加
        seasonSlider.addTarget(self, action: "seasonSlider:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(seasonSlider)
        
        
    }
    
    func setFin(sender: UIButton){
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = ViewController()
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
    }
    
    func timeSlider(sender : UISlider){
    }
    
    func weatherSlider(sender : UISlider){
    }
    
    func placeSlider(sender : UISlider){
    }
    
    func seasonSlider(sender : UISlider){
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}