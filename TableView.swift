//
//  TableView.swift
//  RhythWalk
//
//  Created by 三栖 惇 on 2014/11/27.
//  Copyright (c) 2014年 Jun Murakami. All rights reserved.
//

import Foundation
import UIKit

class TableView: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // テーブルに表示させるデータを用意
    var songQuery: SongQuery = SongQuery()
    var albums: [AlbumInfo] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テーブルを用意して、表示
        var songList: UITableView = UITableView(frame: CGRectMake(0, 70 , self.view.frame.width, self.view.frame.height-70))
//        piyo.registerClass(UITableViewCell.self, forCellReuseIdentifier: "data")
        songList.dataSource = self
        songList.delegate = self
        self.view.addSubview(songList)
        
        self.title = "Songs"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        let goBackButton   = UIButton()
        goBackButton.tag = 6
        goBackButton.frame = CGRectMake(0, 20, 50, 50)
//        goBackButton.layer.position = CGPoint(x:0, y:20)
//        setFinButton.setImage(UIImage(named: "矢印.png") as UIImage, forState: .Normal)
        goBackButton.backgroundColor = UIColor.cyanColor()
        goBackButton.addTarget(self, action: "goBack:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(goBackButton)
        
        albums = songQuery.get()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    下の２つのfuncはDataSourceのプロトコルに定められているモノなので、記載しないとエラーになる
    */
    // sectionの数を返す
    func numberOfSectionsInTableView( tableView: UITableView! ) -> Int {
        return albums.count
    }
    
    // セルの行数を指定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums[section].songs.count
    }
    
    // セルの値を設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell( style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell" )
        cell.textLabel.text = albums[indexPath.section].songs[indexPath.row].songTitle
        cell.detailTextLabel?.text = albums[indexPath.section].songs[indexPath.row].artistName
        return cell
    }
    
    // sectionのタイトル
    func tableView( tableView: UITableView?, titleForHeaderInSection section: Int ) -> String {
        
        return albums[section].albumTitle
    }
    
    // これは無くてもよいけど。セルを選択したときのアクション
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.title = albums[indexPath.section].songs[indexPath.row].songTitle
    }
    
    func goBack(sender: UIButton){
        let mySecondViewController: UIViewController = ViewController()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}