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
    var albumsRow: [AlbumInfo] = []
    var weather: GetWeather = GetWeather()
    
    //var sect: Int
    //var secitem: Int
    
    init(sectionNum: Int, itemNum: Int){
        albums = songQuery.get()
        albumsRow = albums
        sectionCount = albums.count
        
        currentSection = 0//sectionNum
        currentItem = 0//itemNum
    }
    
    
    // sectionの数を返す
    func numberOfSections() -> Int {
        return albums.count
    }
    
    // 各sectionのitem数を返す
    func numberOfItems(section: Int ) -> Int  {
        return albums[section].songs.count
    }
    
    // sectionのタイトル
    func tableView( tableView: UITableView?, titleForHeaderInSection section: Int ) -> String {
        
        return albums[section].albumTitle
    }
    
    //sectはsection（アルバム）で、secitemはアルバムの何番目か
    func musicUrl(var section: Int, var item: Int) -> Void {
        let songId: NSNumber = albums[section].songs[item].songId
        let item: MPMediaItem = songQuery.getItem(songId)
        let url: NSURL = item.valueForProperty(MPMediaItemPropertyAssetURL) as NSURL
        audio = AVAudioPlayer(contentsOfURL: url, error: nil)
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
    
    func musicTitle() -> String {
        let songId: NSNumber = albums[currentSection].songs[currentItem].songId
        let item: MPMediaItem = songQuery.getItem(songId)
        let title: String = item.valueForKey(MPMediaItemPropertyTitle) as String
        return title
    }
    
    func musicArtist() -> String {
        let songId: NSNumber = albums[currentSection].songs[currentItem].songId
        let item: MPMediaItem = songQuery.getItem(songId)
        let artist: String = item.valueForKey(MPMediaItemPropertyArtist) as String
        return artist
    }
    
    func listFromWeather() -> Void {
        albums = songQuery.getListFromWeather(albumsRow,w: weather.chooseWeather2())
        //albums = songQuery.removeSongs(albumsRow)
        
        //        let albums2: [SongInfo] = []
        //        for i in 0..<numberOfSections() {
        //            for j in 0..<numberOfItems(i) {
        //                if(albums[i].songs[j].weather == "Sunny"){
        //                    albums2.append(albums[i].songs[j])
        //                }
        //            }
        //        }
    }
    
    func printSongInfo() -> Void{
        //self.setWeather(currentSection, item: currentItem, weather: "Sunny")
        //let songId: NSNumber = albums[currentSection].songs[currentItem].songId
        //println(albums[currentSection].albumTitle)
        println(albums[currentSection].songs[currentItem].artistName)
        //println(albums[currentSection].songs[currentItem].songId)
        println(albums[currentSection].songs[currentItem].songTitle)
        println(albums[currentSection].songs[currentItem].weather)
    }

    func setWeather(section: Int, item: Int, weather: String) -> Void {
        albums[section].songs[item].weather = weather
    }
    
    func testSetWeather() -> Void {
        for i in 0..<numberOfSections() {
            for j in 0..<numberOfItems(i) {
                if(j%2==0){ setWeather(i, item: j, weather: "Sunny")}
                else if(j%3==0){ setWeather(i, item: j, weather: "Rainy")}
                else if(j%5==0){ setWeather(i, item: j, weather: "Cloudy")}
                else {setWeather(i, item: j, weather: "Snowy")}
            }
        }
        albumsRow = albums
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
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        audio.prepareToPlay()
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
    
    //停止
    func stop() {
        audio.stop()
    }
    
    func setPlayingTime(pos : Double) {
        // 引数に設定された再生位置をプレイヤーに設定
        audio.currentTime = pos
    }
    
    func getPlayingTime() -> String{
        // 引数に設定された再生位置をプレイヤーに設定
        return formatTimeString(audio.currentTime)
    }
    
    func formatTimeString(d : Double) -> String {
        let c = Int(d)
        let m : Int = Int(c / 60)
        let s : Int = Int(c - m * 60)
        let str = String(format: "%02d:%02d", m, s)
        return str
    }
    
}