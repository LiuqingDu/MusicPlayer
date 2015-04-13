//
//  Song.swift
//  MusicPlayer
//
//  Created by Liuqing Du on 13/04/2015.
//  Copyright (c) 2015 JuneDesign. All rights reserved.
//

import UIKit

class Song: NSObject {
    var id: Int!
    var songName: NSString!
    var artistName: NSString!
    var albumName: NSString!
    var songPicSmall: NSString!
    var songPicBig: NSString!
    var songPicRadio: NSString!
    var lrcLink: NSString!
    var songLink: NSString!
    var showLink: NSString!
    
}

//https://gitcafe.com/wcrane/XXXYYY/raw/master/baidu.json
//http://fm.baidu.com/dev/api/?tn=playlist&special=flash&prepend=&format=json&_=1378945264366&id=public_tuijian_rege
//http://music.baidu.com/data/music/fmlink?type=mp3&rate=1&format=json&songids=14921515