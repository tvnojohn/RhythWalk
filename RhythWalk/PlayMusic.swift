//
//  PlayMusic.swift
//  RhythWalk
//
//  Created by 三栖 惇 on 2014/11/05.
//  Copyright (c) 2014年 Jun Murakami. All rights reserved.
//

import Foundation
import MediaPlayer
import AVFoundation

class PlayMusic{
    
    //@IBOutlet var tableView : UITableView
    let myTableView: UITableView = UITableView( frame: CGRectZero, style: .Grouped )
    
    var albums: [AlbumInfo] = []
    var songQuery: SongQuery = SongQuery()
    var audio: AVAudioPlayer! = nil
    
    init(){
        albums = songQuery.get()
        //    self.title = "Songs"
    }
    
    
    // sectionの数を返す
    func numberOfSectionsInTableView( tableView: UITableView! ) -> Int {
        
        return albums.count
    }
    
    // 各sectionのitem数を返す
    func tableView( tableView: UITableView!, numberOfRowsInSection section: Int ) -> Int  {
        
        return albums[section].songs.count
    }
    
//    func tableView( tableView: UITableView?, cellForRowAtIndexPath indexPath:NSIndexPath! ) -> UITableViewCell! {
//        
//        let cell: UITableViewCell = UITableViewCell( style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell" )
//        
//        cell.textLabel.text = albums[indexPath.section].songs[indexPath.row].songTitle
//        cell.detailTextLabel.text = albums[indexPath.section].songs[indexPath.row].artistName
//        
//        return cell;
//    }
    
    // sectionのタイトル
    func tableView( tableView: UITableView?, titleForHeaderInSection section: Int ) -> String {
        
        return albums[section].albumTitle
    }
    
    
    func musicUrl(sect: Int, secitem: Int) -> Void {
        let songId: NSNumber = albums[sect].songs[secitem].songId
        let item: MPMediaItem = songQuery.getItem(songId)
        let url: NSURL = item.valueForProperty(MPMediaItemPropertyAssetURL) as NSURL
        audio = AVAudioPlayer(contentsOfURL: url, error: nil)
        //return url
    }
    
    func play() -> Void{
        audio.play()
    }

    
    // 選択した音楽を再生
    func tableView( tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath! ) {
        
        // soundIdからMediaItemを取得
        let songId: NSNumber = albums[indexPath.section].songs[indexPath.row].songId
        let item: MPMediaItem = songQuery.getItem( songId )
        
        let url: NSURL = item.valueForProperty( MPMediaItemPropertyAssetURL ) as NSURL
        
        // 再生
        play()
        
//        self.title = albums[indexPath.section].songs[indexPath.row].songTitle
    }
    
    func pause() {
        if audio.playing {
            audio.pause()
//          self.title = "Songs"
        }
    }
    
    
}