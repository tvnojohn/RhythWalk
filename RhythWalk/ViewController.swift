//
//  ViewController.swift
//  RhythWalk
//
//  Created by 村上 惇 on 2014/10/08.
//  Copyright (c) 2014年 Jun Murakami. All rights reserved.
//

import UIKit


class ViewController: UIViewController{
    var canvasView_: UIImageView!
    var roundLabel: UILabel!
    var active = false
    var touchCheck = false
    var seekRadian: CGFloat = 0
    var rotate:CGFloat = 1.0;
    var seekRadius: CGFloat = 0
    var b:CGFloat = 270
    var player: PlayMusic = PlayMusic()
    var sec: Int = 1
    var secItem: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.blackColor()
        
        //シークバーの半径
        seekRadius = self.view.frame.height/2 - 185
        
        // 再生停止ボタン
        let image = UIImage(named: "停止ボタン.png") as UIImage
        let image2 = UIImage(named: "再生ボタン.png") as UIImage
        let playButton   = UIButton()
        playButton.tag = 4
        playButton.frame = CGRectMake(0, 0, 50, 50)
        playButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height*0.75)//500)
        if(active==false){
            playButton.setImage(image2, forState: .Normal)
        }
        else{
            playButton.setImage(image, forState: .Normal)
        }
        playButton.addTarget(self, action: "tapped:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(playButton)
        
        
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
        myImageView.transform = CGAffineTransformScale(myImageView.transform, rotate, 1.0)
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
        
        NSTimer.scheduledTimerWithTimeInterval(0.4,target:self,selector:"seekMove", userInfo: nil, repeats: true)
        
        player.musicUrl(sec, secitem: 1)
    }

    func tapped(sender: UIButton){
        let image = UIImage(named: "停止ボタン.png") as UIImage
        let image2 = UIImage(named: "再生ボタン.png") as UIImage
        if(active==false){
            sender.setImage(image, forState: .Normal)
            active = true
            
            player.play()
        }
        else{
            sender.setImage(image2, forState: .Normal)
            active = false
            player.pause()
        }
    }
    
    func seekMove(){
        if(active==true && touchCheck==false){
            b = b + 6
            let c = CGFloat(M_PI / 180)
            let a :CGFloat = b  * c
            rotate = a
            UIView.animateWithDuration(
                0.5,
                delay: 0,
                options: UIViewAnimationOptions.CurveEaseIn,
                animations: {
                    self.roundLabel.layer.position = CGPoint(x: self.view.frame.width/2 + self.seekRadius * cos(self.rotate), y: self.view.frame.height/2 + self.seekRadius * sin(self.rotate))
                },
                completion:{
                    (value: Bool) in
                    println("Animation End");
                }
            )
            println(rotate);
        }
        //roundLabel.layer.position = CGPoint(x: self.view.bounds.width/2 + rotate/1000, y: 185
    }
    
    func radianCalc(){
        //シークバーの角度を求める
        var PI = CGFloat(M_PI)
        var ladiusX = acos((roundLabel.layer.position.x - self.view.frame.width/2) / seekRadius) / PI * 180
        if(roundLabel.layer.position.x <= self.view.frame.width/2 + seekRadius && roundLabel.layer.position.x >= self.view.frame.width/2){
            if(roundLabel.layer.position.y >= self.view.frame.height/2 - seekRadius && roundLabel.layer.position.y <= self.view.frame.height/2){
                b =  ladiusX
            }else{
                b =  90+ladiusX
            }
        }else{
            if(roundLabel.layer.position.y <= self.view.frame.height/2 + seekRadius && roundLabel.layer.position.y >= self.view.frame.height/2){
                b =  90+ladiusX
            }else{
                b =  180+ladiusX
            }
        }
        println(b);

    }
    
    func skip(sender: UIButton){
        
    }
    
    func buck(sender: UIButton){
        
    }
    
    func set(sender: UIButton){
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = SecondViewController()
            
        // アニメーションを設定する.
        //mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
    }
    
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
        var round_z = (round_y)/bent + self.view.bounds.height/2
        roundLabel.layer.position = CGPoint(x: (round_x)/bent + self.view.frame.width/2,y: (round_y)/bent + self.view.frame.height/2)
        roundLabel.transform = CGAffineTransformMakeScale(1.0, 1.0)
        touchCheck = false
        radianCalc()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

