//
//  ViewController.swift
//  RhythWalk
//
//  Created by 村上 惇 on 2014/10/08.
//  Copyright (c) 2014年 Jun Murakami. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController{
    
    var canvasView_: UIImageView!
    var roundLabel: UILabel!
    var active = false
    var touchCheck = false
    var seekRadian: CGFloat = 0
    var rotate:CGFloat = 1.0
    var seekRadius: CGFloat = 0
    var b:CGFloat = 270
    let player: PlayMusic = PlayMusic(sectionNum: 0,itemNum: 0)////////////////////////<=
    let playButton   = UIButton()
    
    //BPM関係
    var myStepCounter: CMStepCounter!
    var count5Time: Int64 = 0
    var bpm: NSNumber = 124
    var myStep: NSNumber! = 0
    var step: NSNumber! = 0
    var bpm2: NSNumber = 0
    var bpmLabel: UILabel!
    
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    
    var musicTitleLabel: UILabel!
    var playTimeLabel: UILabel!
    var musicianNameLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.blackColor()
        
        //シークバーの半径
        seekRadius = self.view.frame.height/2 - 185
        
        // 再生停止ボタン
        let image = UIImage(named: "停止ボタン.png") as UIImage
        let image2 = UIImage(named: "再生ボタン.png") as UIImage
        playButton.tag = 4
        playButton.frame = CGRectMake(0, 0, 50, 50)
        playButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height*0.9)//500)
        if(active==false){
            playButton.setImage(image2, forState: .Normal)
        }
        else{
            playButton.setImage(image, forState: .Normal)
        }
        playButton.addTarget(self, action: "tapped:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(playButton)
        
        //画面上部の白いバー
        let buckber = UILabel(frame: CGRectMake(0,0,self.view.frame.width,35))
        buckber.backgroundColor = UIColor.whiteColor()
        buckber.layer.position = CGPoint(x: self.view.bounds.width/2 ,y: 0)
        self.view.addSubview(buckber)
        
        // スキップボタン
        let skipButton   = UIButton()
        skipButton.tag = 4
        skipButton.frame = CGRectMake(0, 0, 60, 60)
        skipButton.layer.position = CGPoint(x:298, y:self.view.frame.height/2)
        skipButton.setImage(UIImage(named: "button_right.png") as UIImage, forState: .Normal)
        skipButton.addTarget(self, action: "skip:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(skipButton)

        // バックボタン
        let buckButton   = UIButton()
        buckButton.tag = 4
        buckButton.frame = CGRectMake(0, 0, 60, 60)
        buckButton.layer.position = CGPoint(x:22, y:self.view.frame.height/2)
        buckButton.setImage(UIImage(named: "button_left.png") as UIImage, forState: .Normal)
        buckButton.addTarget(self, action: "buck:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(buckButton)
        
        // 設定ボタン
        let setButton   = UIButton()
        setButton.tag = 4
        setButton.frame = CGRectMake(0, 0, 75, 75)
        setButton.layer.position = CGPoint(x:self.view.frame.width-30, y:self.view.frame.height-50)
        setButton.setImage(UIImage(named: "矢印.png") as UIImage, forState: .Normal)
        setButton.addTarget(self, action: "set:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(setButton)

        // 音符
        let myImageView: UIImageView = UIImageView(frame: CGRectMake(0,0,190,180))
        let myImage = UIImage(named: "musicalnote_shadow.png")
        myImageView.image = myImage
        myImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.frame.height/2)
        myImageView.alpha = 10.0
        myImageView.transform = CGAffineTransformScale(myImageView.transform, 1.0, 1.0)
        self.view.addSubview(myImageView)
        
        // シークバー
        let seekbarView: UIImageView = UIImageView(frame: CGRectMake(0,0,250,250))
        let seekbarImage = UIImage(named: "seekbar1.png")
        seekbarView.image = seekbarImage
        seekbarView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.frame.height/2)
        self.view.addSubview(seekbarView)
        
        // 円のシークバーを作成
        roundLabel = UILabel(frame: CGRectMake(0,0,30,30))
        roundLabel.backgroundColor = UIColor.greenColor()
        roundLabel.layer.masksToBounds = true
        roundLabel.layer.cornerRadius = 15.0
        roundLabel.textColor = UIColor.whiteColor()
        roundLabel.shadowColor = UIColor.grayColor()
        roundLabel.font = UIFont.systemFontOfSize(CGFloat(30))
        roundLabel.textAlignment = NSTextAlignment.Center
        roundLabel.layer.position = CGPoint(x: self.view.frame.width/2, y: 185)
        self.view.addSubview(roundLabel)
        
        NSTimer.scheduledTimerWithTimeInterval(0.1,target:self,selector:"count5Sec", userInfo: nil, repeats: true)
        
        player.musicUrl(0, item: 0)        ////////////////////////<=
        //player.musicLyrics(sec, secitem: 0)
        
        // 歩数計を生成.
        myStepCounter = CMStepCounter()
        
        // ペドメーター(歩数計)で計測開始.
        myStepCounter.startStepCountingUpdatesToQueue(NSOperationQueue.mainQueue(), updateOn: 1, withHandler:
            {numberOfSteps, timeStamp, error in
                if error==nil {
                    self.myStep = numberOfSteps
                }
        })
        
        
        myStepCounter.stopStepCountingUpdates()
        
        // BPM表示
        bpmLabel = UILabel(frame: CGRectMake(0,0, 100, 22))
        //bpmLabel.text = "BPM:"
        bpmLabel.textColor = UIColor.whiteColor()
        bpmLabel.shadowColor = UIColor.whiteColor()
        bpmLabel.textAlignment = .Center
        bpmLabel.layer.position = CGPoint(x: self.view.bounds.width/2 ,y: 50)
        self.view.addSubview(bpmLabel)
        
        // 曲名表示
        musicTitleLabel = UILabel(frame: CGRectMake(0,0, 200, 22))
        musicTitleLabel.text = player.musicTitle()
        musicTitleLabel.textColor = UIColor.whiteColor()
        musicTitleLabel.shadowColor = UIColor.whiteColor()
        musicTitleLabel.textAlignment = .Center
        musicTitleLabel.layer.position = CGPoint(x: self.view.bounds.width/2 ,y:self.view.bounds.height/2 - 30)
        self.view.addSubview(musicTitleLabel)
        
        // 歌手名表示
        musicianNameLabel = UILabel(frame: CGRectMake(0,0, 200, 22))
        musicianNameLabel.text = player.musicArtist()
        musicianNameLabel.textColor = UIColor.whiteColor()
        musicianNameLabel.shadowColor = UIColor.whiteColor()
        musicianNameLabel.textAlignment = .Center
        musicianNameLabel.layer.position = CGPoint(x: self.view.bounds.width/2 ,y:self.view.bounds.height/2)
        self.view.addSubview(musicianNameLabel)
        
        // 再生位置
        playTimeLabel = UILabel(frame: CGRectMake(0,0, 200, 22))
        playTimeLabel.text = "\(player.getPlayingTime())/ \(player.formatTimeString(player.musicPlayingTime()))"
        playTimeLabel.textColor = UIColor.whiteColor()
        playTimeLabel.shadowColor = UIColor.whiteColor()
        playTimeLabel.textAlignment = .Center
        playTimeLabel.layer.position = CGPoint(x: self.view.bounds.width/2 ,y:self.view.bounds.height/2 + 30)
        self.view.addSubview(playTimeLabel)
    }

    //音楽再生ボタン
    func tapped(sender: UIButton){
        let image = UIImage(named: "停止ボタン.png") as UIImage
        let image2 = UIImage(named: "再生ボタン.png") as UIImage
        if(active==false){
            sender.setImage(image, forState: .Normal)
            musicShuffle()
            active = true
            setSeekbarTime()
            player.play()
        }
        else{
            sender.setImage(image2, forState: .Normal)
            active = false
            player.pause()
        }
    }
    
    //再生中のスタイリッシュシークバー
    func seekMove(){
        if(active==true && touchCheck==false){
            b = b + 36.00/CGFloat(player.musicPlayingTime())    ////////////////////////<=
            let c = CGFloat(M_PI / 180)
            let a :CGFloat = b  * c
            rotate = a
            UIView.animateWithDuration(
                1,
                delay: 0,
                options: UIViewAnimationOptions.CurveLinear,
                animations: {
                    self.roundLabel.layer.position = CGPoint(x: self.view.frame.width/2 + self.seekRadius * cos(self.rotate), y: self.view.frame.height/2 + self.seekRadius * sin(self.rotate))
                },
                completion:{
                    (value: Bool) in
                }
            )
            //println(rotate);
        }
        //roundLabel.layer.position = CGPoint(x: self.view.bounds.width/2 + rotate/1000, y: 185
    
        if(b >= 630){
            //if(bpm<=bpm2-8 || bpm >= bpm2+8){
            player.nextSong()
            b = 270
            musicShuffle()
            player.play()
            //}
        }
        playTimeLabel.text = "\(player.getPlayingTime())/ \(player.formatTimeString(player.musicPlayingTime()))"
    }
    
    //シークバーの角度を求める
    func radianCalc(){
        //シークバーの角度を求める
        var ladiusX:CGFloat = 0
        var PI = CGFloat(M_PI)
        if(roundLabel.layer.position.y <= self.view.frame.height/2 + 10 && roundLabel.layer.position.y > self.view.frame.height/2 - 10){
            if(roundLabel.layer.position.x > self.view.frame.width/2 + seekRadius - 5){
                ladiusX = 360
                b = 360
            }else if(roundLabel.layer.position.x < self.view.frame.width/2 - seekRadius + 5){
                ladiusX = 540
                b = 540
            }
        }else{
            ladiusX = acos((roundLabel.layer.position.x - self.view.frame.width/2) / seekRadius) / PI * 180
            println("ladiusX:\(ladiusX)")
            if(roundLabel.layer.position.x <= self.view.frame.width/2 + seekRadius && roundLabel.layer.position.x >= self.view.frame.width/2){
                if(roundLabel.layer.position.y >= self.view.frame.height/2 - seekRadius - 5 && roundLabel.layer.position.y <= self.view.frame.height/2){
                    b =  360 - ladiusX
                }else{
                    b = ladiusX + 360
                }
            }else{
                if(roundLabel.layer.position.y <= self.view.frame.height/2 + seekRadius + 5 && roundLabel.layer.position.y > self.view.frame.height/2){
                    b =  ladiusX + 360
                }else{
                    b =  720 - ladiusX
                }
                
            }

        }
    
        println(b);
        setSeekbarTime()
    }
    
    //音楽再生位置の変更
    func setSeekbarTime(){
        var g:NSNumber = 0
        if(b < 270){
            g = NSNumber(float: Float(b + 90) / 360 * player.musicPlayingTime())
        }else{
            g = NSNumber(float: Float(b - 270) / 360 * player.musicPlayingTime())
        }
        player.setPlayingTime(g)
    }
    
    //音楽を次の曲に
    func skip(sender: UIButton){
        b = 270                 ////////////////////////<=
        if(active==false){
            tapped(playButton)
        }
        self.seekMove()
        player.nextSong()
        musicShuffle()
        player.play()
    }
    
    func buck(sender: UIButton){
        b = 270                 ////////////////////////<=
        self.seekMove()
        if(active==false){
            tapped(playButton)
        }
        player.previousSong()
        musicTitleLabel.text = player.musicTitle()
        musicianNameLabel.text = player.musicArtist()
        player.play()
    }
    
    //画面遷移
    func set(sender: UIButton){
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = SecondViewController()
        
        // アニメーションを設定する.
        //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
    }
    
    //シークバータッチ処理
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // シークバーに触れているかチェック
        let touch :UITouch = touches.anyObject() as UITouch
        let currentPoint = touch.locationInView(self.canvasView_)
        /*if(currentPoint.x > roundLabel.layer.position.x - 10 && currentPoint.x < roundLabel.layer.position.x + 20){
            if(currentPoint.y > roundLabel.layer.position.y - 10 && currentPoint.y < roundLabel.layer.position.y + 20){
                touchCheck = true
                roundLabel.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }
        }*/
        //if(active==true){
            if(currentPoint.x > roundLabel.layer.position.x - 30 && currentPoint.x < roundLabel.layer.position.x + 40){
                if(currentPoint.y > roundLabel.layer.position.y - 30 && currentPoint.y < roundLabel.layer.position.y + 40){
                    touchCheck = true
                    roundLabel.transform = CGAffineTransformMakeScale(1.5, 1.5)
                }
            }
        //}
    }
    
    //シークバータッチ処理
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if(touchCheck == false){
            return;
        }
        //シークバーをタッチしている座標に動かす
        let touch :UITouch = touches.anyObject() as UITouch
        let currentPoint = touch.locationInView(self.canvasView_)
        var bent:CGFloat
        var round_x = currentPoint.x-self.view.frame.width/2
        var round_y = currentPoint.y-self.view.frame.height/2
        bent = (round_x * round_x + round_y * round_y)/10000
        bent = sqrt(bent)
        var round_z = (round_y)/bent + self.view.frame.height/2
        roundLabel.layer.position = CGPoint(x: (round_x)/bent + self.view.frame.width/2,y: (round_y)/bent + self.view.frame.height/2)
    }
    
    //シークバータッチ終了処理
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        if(touchCheck == false){
            return;
        }
        // タッチが終わった時の座標にシークバーを移動
        var touch: UITouch = touches.anyObject() as UITouch
        var point: CGPoint = touch.locationInView(self.canvasView_)
        var bent:CGFloat
        var round_x = point.x-self.view.frame.width/2
        var round_y = point.y-self.view.frame.height/2
        bent = (round_x * round_x + round_y * round_y)/10000
        bent = sqrt(bent)
        roundLabel.layer.position = CGPoint(x: (round_x)/bent + self.view.frame.width/2,y: (round_y)/bent + self.view.frame.height/2)
        roundLabel.transform = CGAffineTransformMakeScale(1.0, 1.0)
        touchCheck = false
        radianCalc()
    }
    
    //5秒カウントする
    func count5Sec(){
        seekMove()
        if(appDelegate.mySituation.BPMCheck == true){
            count5Time = count5Time + 1
            if(count5Time==50){
                myBPM()
                count5Time = 0
            }
        }else{
            bpm = 0
            count5Time = 49
            bpmLabel.text = " "
        }
    }
    
    //BPMの計算
    func myBPM() ->Void{
        bpm = 12 * (myStep - step)
        step = myStep
        //println(bpm)
        bpmLabel.text = ("BPM:\(bpm)")
    }
    
    //BPMと一致した曲にする
    func musicShuffle(){
        if(bpm != 0 || (bpm > 79 && bpm < 210)){
            while(player.musicBPM() >= bpm + 8 || player.musicBPM() <= bpm - 7) {
                player.nextSong()
            }
        }
        else{
        }
        println(bpm)
        println(player.musicBPM())
        bpm2 = player.musicBPM()
        musicTitleLabel.text = player.musicTitle()
        musicianNameLabel.text = player.musicArtist()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

