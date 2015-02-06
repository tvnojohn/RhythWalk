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
    
    func initAlbums()->Void{
        albums = albumsRow
        setSituationForDemo()
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
    
    func listFrom(situation: String) -> Void {
        albums = songQuery.getListFrom(albums,w:situation )//albums = songQuery.removeSongs(albumsRow)
        
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
        var r: Int = 0
        for var i = 0; i <= 4; i++ {
            r = Int(arc4random() % 100 + 1)
        }
        albums[section].songs[item].weather[weather] = r
    }
    
    func testSetWeather() -> Void {
        for i in 0..<numberOfSections() {
            for j in 0..<numberOfItems(i) {
                if(j%2==0){ setWeather(i, item: j, weather: "sunny")}
                if(j%3==0){ setWeather(i, item: j, weather: "rainy")}
                if(j%5==0){ setWeather(i, item: j, weather: "cloudy")}
                //else {setWeather(i, item: j, weather: "snowy")}
            }
        }
        albumsRow = albums
    }
    
    func setSituationForDemo() -> Void {
        
        //akanesora
        albums[0].songs[0].time["evening"] = 1
        albums[0].songs[0].weather["rainy"] = 0

        //aruiteikou
        albums[1].songs[0].weather["sunny"] = 0
        albums[1].songs[0].weather["rainy"] = 0
        
        //ameuta
        albums[2].songs[0].weather["rainy"] = 1
        //akaneironoyakusoku
        albums[3].songs[0].time["evening"] = 1
        albums[3].songs[0].weather["rainy"] = 0
        //orange
        albums[4].songs[0].time["evening"] = 1
        albums[4].songs[0].weather["rainy"] = 0
        //kakumei
        albums[5].songs[0].weather["sunny"] = 0
        albums[5].songs[0].weather["rainy"] = 0
        //natunoomoide
        albums[6].songs[0].season["summer"] = 1
        albums[6].songs[0].weather["rainy"] = 0
        //ningentteiina
        albums[7].songs[0].time["evening"] = 1
        albums[7].songs[0].weather["rainy"] = 0
        //otokogokorotoakinosora
        albums[8].songs[0].season["fall"] = 1
        //poni-
        albums[9].songs[0].season["summer"] = 1
        albums[9].songs[0].time["afternoon"] = 1
            //konayuki
            albums[10].songs[0].weather["snowy"] = 1
            albums[10].songs[0].season["winter"] = 1
            //sakura
            albums[11].songs[0].season["spring"] = 1
            //sayonara
            albums[12].songs[0].time["evening"] = 1
            //hanataba
            albums[13].songs[0].time["morning"] = 0
            
            //tsubasa
            albums[14].songs[0].season["fall"] = 1
            //donten
            albums[15].songs[0].weather["cloudy"] = 1
            //natuzora
            albums[16].songs[0].weather["sunny"] = 1
            albums[16].songs[0].time["morning"] = 1
            albums[16].songs[0].time["afternoon"] = 1
            //natumaturi
            albums[17].songs[0].season["summer"] = 1
            //makkanasora
            albums[18].songs[0].season["fall"] = 1
            albums[18].songs[0].time["evening"] = 1
            //sankaku
            albums[19].songs[0].season["summer"] = 1
            albums[19].songs[0].time["night"] = 1
            //haretokidoki
            albums[20].songs[0].weather["cloudy"] = 1
            
            //lovinlife
            albums[21].songs[0].season["spring"] = 1
            
            //saboten
            albums[22].songs[0].weather["rainy"] = 1
            //manatunosoundsgood
            albums[23].songs[0].season["summer"] = 1
            albums[23].songs[0].time["afternoon"] = 1
            //tete
            albums[24].songs[0].weather["sunny"] = 0
            //snowsmile
            albums[25].songs[0].weather["snowy"] = 1
            albums[25].songs[0].season["winter"] = 1
            
            //ituka
            albums[26].songs[0].weather["snowy"] = 1
            albums[26].songs[0].weather["rainy"] = 1
            albums[26].songs[0].season["winter"] = 1
            //hanabi
            albums[27].songs[0].season["summer"] = 1
            //sauda-ji
            albums[28].songs[0].season["fall"] = 1
            //koyoituki
            albums[29].songs[0].time["night"] = 1
            //beloved
            albums[30].songs[0].season["fall"] = 1
            //promise
            albums[31].songs[0].season["winter"] = 1
            
            //sakurazaka
            albums[32].songs[0].season["spring"] = 1
            
            //hanbunko
            albums[33].songs[0].weather["cloudy"] = 0
            //anokamihikouki
            albums[34].songs[0].weather["cloudy"] = 1
            //haru
            albums[35].songs[0].season["spring"] = 1
            //tentaikansoku
            albums[36].songs[0].time["night"] = 1
            
            //itukanomerry
            albums[37].songs[0].season["winter"] = 1
            //ainouta
            albums[38].songs[0].time["morning"] = 1
            //asagamatakuru
            albums[39].songs[0].weather["sunny"] = 1
            albums[39].songs[0].weather["rainy"] = 1
            albums[39].songs[0].time["morning"] = 1
            //kiminote
            albums[40].songs[0].season["fall"] = 1
            //gakuenbaby
            albums[41].songs[0].time["afternoon"] = 1
            //growup
            albums[42].songs[0].time["morning"] = 0
            //wakemeup
            albums[43].songs[0].time["morning"] = 1
            //natuiro
            albums[44].songs[0].season["summer"] = 1
            //naminorijony
            albums[45].songs[0].season["summer"] = 1
            albums[45].songs[0].time["afternoon"] = 1
            //kurumi
            albums[46].songs[0].season["fall"] = 1
            //houkiboshi
            albums[47].songs[0].time["night"] = 1
            //rain
            albums[48].songs[0].weather["rainy"] = 1
            //am1100
            albums[49].songs[0].time["morning"] = 1
            //shiroikoibito
            albums[50].songs[0].weather["snowy"] = 1
            albums[50].songs[0].season["winter"] = 1
            //winteragain
            albums[51].songs[0].weather["snowy"] = 1
            albums[51].songs[0].season["winter"] = 1
            //yeah
            albums[52].songs[0].weather["sunny"] = 1
            albums[52].songs[0].season["summer"] = 1
            //39
            albums[53].songs[0].season["spring"] = 1
            albums[53].songs[0].time["morning"] = 1
            //niji
            albums[54].songs[0].weather["sunny"] = 1
            
            //begin
            albums[55].songs[0].weather["snowy"] = 0
            //aoishiori
            albums[56].songs[0].weather["sunny"] = 1
            albums[56].songs[0].time["morning"] = 1
        
        
    }
    
    //一つ次の曲へ移る
    func nextSong(){
        itemCount = numberOfItems(currentSection)
        sectionCount = numberOfSections()
        
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
        sectionCount = numberOfSections()
        
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
    
    //再生時間を返す
    func getMusicPlayingTime() -> Double {
        let songId: NSNumber = albums[currentSection].songs[currentItem].songId
        let item: MPMediaItem = songQuery.getItem(songId)
        let time: NSNumber = item.valueForKey(MPMediaItemPropertyPlaybackDuration) as NSNumber
        return Double(time)
    }
    
}