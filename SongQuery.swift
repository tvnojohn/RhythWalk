//
//  SongQuery.swift
//  RhythWalk
//
//  Created by 三栖 惇 on 2014/11/05.
//  Copyright (c) 2014年 Jun Murakami. All rights reserved.
//

import Foundation
import MediaPlayer

// 曲情報
struct SongInfo {
    
    var albumTitle: String
    var artistName: String
    var songTitle:  String
    
    // UInt64だとうまくいかなかった。バグ？
    var songId   :  NSNumber
    
    var weather: String
}

// アルバム情報
struct AlbumInfo {
    
    var albumTitle: String
    var songs: [SongInfo]
}

class SongQuery {
    
    // iPhoneに入ってる曲を全部返す
    func get() -> [AlbumInfo] {
        
        var albums: [AlbumInfo] = []
        
        // アルバム情報から曲を取り出す
        var albumsQuery: MPMediaQuery = MPMediaQuery.albumsQuery()
        var albumItems: [MPMediaItemCollection] = albumsQuery.collections as [MPMediaItemCollection]
        var album: MPMediaItemCollection
        
        for album in albumItems {
            
            var albumItems: [MPMediaItem] = album.items as [MPMediaItem]
            var song: MPMediaItem
            
            var songs: [SongInfo] = []
            
            var albumTitle: String = ""
            
            for song in albumItems {
                
                albumTitle = song.valueForProperty( MPMediaItemPropertyAlbumTitle ) as String
                
                var songInfo: SongInfo = SongInfo(
                    albumTitle: song.valueForProperty( MPMediaItemPropertyAlbumTitle ) as String,
                    artistName: song.valueForProperty( MPMediaItemPropertyArtist ) as String,
                    songTitle:  song.valueForProperty( MPMediaItemPropertyTitle ) as String,
                    songId:     song.valueForProperty( MPMediaItemPropertyPersistentID ) as NSNumber,
                    weather:    String("")// = "nothing"//song.valueForProperty(MPMediaItemPropertyComments) as String,
                )
                
                songs.append( songInfo )
            }
            
            var albumInfo: AlbumInfo = AlbumInfo(
                
                albumTitle: albumTitle,
                songs: songs
            )
            
            albums.append( albumInfo )
        }
        
        return albums
        
    }
    
    func getListFromWeather(albumsRow:[AlbumInfo], w: String) -> [AlbumInfo] {
        var albums: [AlbumInfo] = albumsRow
        var albums2: [AlbumInfo] = []
        
        for album in albums {
            var albumItems: [SongInfo] = album.songs
            var songs: [SongInfo] = []
            var weatherCount: Int = 0
            
            for song in albumItems {
                if(song.weather == w){songs.append( song ); weatherCount++ }
            }
            
            var albumInfo: AlbumInfo = AlbumInfo(
                albumTitle: album.albumTitle,
                songs: songs
            )
            
            if(weatherCount != 0){ albums2.append( albumInfo ) }
        }
        
        return albums2
        
    }
    
    func removeSongs(albumsRow: [AlbumInfo]) -> [AlbumInfo] {
        var albums: [AlbumInfo] = albumsRow
        var albums2: [AlbumInfo] = []
        
        for album in albums {
            var albumItems: [SongInfo] = album.songs
            //            var songs: [SongInfo] = []
            //            var count: Int = 0
            
            for(var i = album.songs.count-1; 0 <= i ; i--) {
                if (album.songs[i].weather != "Sunny"){
                    albumItems.removeAtIndex(i)
                }
                
                //                count++
            }
        }
        return albums
    }

    
    // songIdからMediaItemを取り出す
    func getItem( songId: NSNumber ) -> MPMediaItem {
        
        var property: MPMediaPropertyPredicate = MPMediaPropertyPredicate( value: songId, forProperty: MPMediaItemPropertyPersistentID )
        
        var query: MPMediaQuery = MPMediaQuery()
        query.addFilterPredicate( property )
        
        var items: [MPMediaItem] = query.items as [MPMediaItem]
        
        return items[items.count - 1]
        
    }
    
}
