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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.blackColor()
        
        
        // 再生停止ボタン
        let image = UIImage(named: "停止ボタン.png") as UIImage
        let image2 = UIImage(named: "再生ボタン.png") as UIImage
        let playButton   = UIButton()
        playButton.tag = 4
        playButton.frame = CGRectMake(0, 0, 50, 50)
        playButton.layer.position = CGPoint(x: self.view.frame.width/2, y:500)
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
        myImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        myImageView.alpha = 0.5
        myImageView.transform = CGAffineTransformScale(myImageView.transform, rotate, 1.0)
        self.view.addSubview(myImageView)
        
        // シークバー
        let seekbarView: UIImageView = UIImageView(frame: CGRectMake(0,0,250,250))
        let seekbarImage = UIImage(named: "seekbar1.png")
        seekbarView.image = seekbarImage
        seekbarView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        self.view.addSubview(seekbarView)
        
        // 円のシークバーを作成
        roundLabel = UILabel(frame: CGRectMake(0,0,20,20))
        roundLabel.backgroundColor = UIColor.greenColor()
        roundLabel.layer.masksToBounds = true
        roundLabel.layer.cornerRadius = 10.0
        roundLabel.textColor = UIColor.whiteColor()
        roundLabel.shadowColor = UIColor.grayColor()
        roundLabel.font = UIFont.systemFontOfSize(CGFloat(30))
        roundLabel.textAlignment = NSTextAlignment.Center
        roundLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 185)
        self.view.addSubview(roundLabel)

    }

    func tapped(sender: UIButton){
        let image = UIImage(named: "停止ボタン.png") as UIImage
        let image2 = UIImage(named: "再生ボタン.png") as UIImage
        //let imageButton   = UIButton()
        
        if(active==false){
            sender.setImage(image, forState: .Normal)
            active = true
        }
        else{
            sender.setImage(image2, forState: .Normal)
            active = false
        }
        self.view.addSubview(sender)
        //println("Tapped Button Tag:\(sender.tag)")
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
        if(currentPoint.x > roundLabel.layer.position.x - 10 && currentPoint.x < roundLabel.layer.position.x + 20){
            if(currentPoint.y > roundLabel.layer.position.y - 10 && currentPoint.y < roundLabel.layer.position.y + 20){
                touchCheck = true
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if(touchCheck == false){
            return;
        }
        //シークバーをタッチしている座標に動かす
        let touch :UITouch = touches.anyObject() as UITouch
        let currentPoint = touch.locationInView(self.canvasView_)
        var bent:CGFloat
        var round_x = currentPoint.x-self.view.bounds.width/2
        var round_y = currentPoint.y-self.view.bounds.height/2
        bent = (round_x * round_x + round_y * round_y)/10000
        bent = sqrt(bent)
        var round_z = (round_y)/bent + self.view.bounds.height/2
        roundLabel.layer.position = CGPoint(x: (round_x)/bent + self.view.bounds.width/2,y: (round_y)/bent + self.view.bounds.height/2)
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
        var round_x = point.x-self.view.bounds.width/2
        var round_y = point.y-self.view.bounds.height/2
        bent = (round_x * round_x + round_y * round_y)/10000
        bent = sqrt(bent)
        var round_z = (round_y)/bent + self.view.bounds.height/2
        roundLabel.layer.position = CGPoint(x: (round_x)/bent + self.view.bounds.width/2,y: (round_y)/bent + self.view.bounds.height/2)
        touchCheck = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

