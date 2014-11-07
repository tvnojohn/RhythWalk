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
    var itemCount: Int = 0
    var sectionCount: Int = 0
    var currentSection: Int = 0
    var currentItem: Int = 0
    
    //var sect: Int
    //var secitem: Int
    
    init(sectionNum: Int, itemNum: Int){
        albums = songQuery.get()
        //    self.title = "Songs"
        sectionCount = albums.count
        
        currentSection = sectionNum
        currentItem = itemNum
    }
    
    
    // sectionの数を返す
    func numberOfSections() -> Int {
        return albums.count
    }
    
    // 各sectionのitem数を返す
    func numberOfItems(section: Int ) -> Int  {
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
    
    //sectはsection（アルバム）で、secitemはアルバムの何番目か
    func musicUrl(var section: Int, var item: Int) -> Void {
//        if section != nil && item != nil{}else{section = currentSection;item = currentItem}
//        var url: NSURL = NSURL.URLWithString("")
        //for(var section: Int = sect; url.isEqual(nil) == true ; section++){
        let songId: NSNumber = albums[section].songs[item].songId
        let item: MPMediaItem = songQuery.getItem(songId)
        let url: NSURL = item.valueForProperty(MPMediaItemPropertyAssetURL) as NSURL
        //}
        //let url2 = url
        audio = AVAudioPlayer(contentsOfURL: url, error: nil)
        //return url
    }
    
    //歌詞を返す（ただし登録されいるものに限る）
    func musicLyrics() -> Void {
        let songId: NSNumber = albums[currentSection].songs[currentItem].songId
        let item: MPMediaItem = songQuery.getItem(songId)
        let lyrics: NSString = item.valueForKey(MPMediaItemPropertyLyrics) as NSString
        println(lyrics)
    }
    
    //再生時間を返す
    func musicPlayingTime() -> NSNumber {
        let songId: NSNumber = albums[currentSection].songs[currentItem].songId
        let item: MPMediaItem = songQuery.getItem(songId)
        let time: NSNumber = item.valueForKey(MPMediaItemPropertyPlaybackDuration) as NSNumber
        return time
    }
    
    //BPMを返す（ただし登録されているものに限る）
    func musicBPM() -> NSNumber {
        let songId: NSNumber = albums[currentSection].songs[currentItem].songId
        let item: MPMediaItem = songQuery.getItem(songId)
        let bpm: NSNumber = item.valueForKey(MPMediaItemPropertyBeatsPerMinute) as NSNumber
        return bpm
    }
    
    //一つ次の曲へ移る
    func nextSong(){
        itemCount = numberOfItems(currentSection)
        
        if currentItem == itemCount-1 && currentSection == sectionCount-1 {
            currentSection = 0
            currentItem = 0
        }else if currentItem == itemCount-1 {
            currentItem = 0
            currentSection++
        }else{
            currentItem++
        }
        musicUrl(currentSection, item: currentItem)
    }
    
    func playFirst(){
        musicUrl(currentSection, item: currentItem)
        //play()
    }
    
    //一つ前の曲へ戻る
    func previousSong(){
        itemCount = numberOfItems(currentSection)
        
        if currentItem == 0 && currentSection == 0 {
            currentSection = sectionCount-1
            currentItem = numberOfItems(currentSection)-1
        }else if currentItem == 0 {
            currentSection--
            currentItem = numberOfItems(currentSection)-1
        }else{
            currentItem--
        }
        musicUrl(currentSection, item: currentItem)
    }
    
    //再生
    func play() -> Void{
        audio.play()
    }

    
    // 選択した音楽を再生
//    func tableView( tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath! ) {
//        
//        // soundIdからMediaItemを取得
//        let songId: NSNumber = albums[indexPath.section].songs[indexPath.row].songId
//        let item: MPMediaItem = songQuery.getItem( songId )
//        
//        let url: NSURL = item.valueForProperty( MPMediaItemPropertyAssetURL ) as NSURL
//        
//        // 再生
//        play()
//        
////        self.title = albums[indexPath.section].songs[indexPath.row].songTitle
//    }
    
    //一時停止
    func pause() {
        if audio.playing {
            audio.pause()
//          self.title = "Songs"
        }
    }
    
    
}