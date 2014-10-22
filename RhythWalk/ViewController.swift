//
//  ViewController.swift
//  RhythWalk
//
//  Created by 村上 惇 on 2014/10/08.
//  Copyright (c) 2014年 Jun Murakami. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var active = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // *** UIButton with Image ***
        let image = UIImage(named: "停止ボタン.png") as UIImage
        let image2 = UIImage(named: "再生ボタン.png") as UIImage
        let imageButton   = UIButton()
        imageButton.tag = 4
        imageButton.frame = CGRectMake(0, 0, 50, 50)
        imageButton.layer.position = CGPoint(x: self.view.frame.width/2, y:500)
        if(active==false){
            imageButton.setImage(image2, forState: .Normal)
        }
        else{
            imageButton.setImage(image, forState: .Normal)
        }
        imageButton.addTarget(self, action: "tapped:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(imageButton)


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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

