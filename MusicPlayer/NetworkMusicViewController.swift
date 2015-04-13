//
//  NetworkMusicViewController.swift
//  MusicPlayer
//
//  Created by Liuqing Du on 13/04/2015.
//  Copyright (c) 2015 JuneDesign. All rights reserved.
//

import UIKit
import MediaPlayer

class NetworkMusicViewController: UIViewController {
    
    var songList: Array<Song> = []
    var currentSong: Song!
    
    var audioPlayer:MPMoviePlayerController = MPMoviePlayerController();
    
    func loadSong() {
        
        var url:NSString = "http://box.zhangmen.baidu.com/x?op=12&count=1&title=\(currentSong.songName)$$\(currentSong.artistName)$$$$"
        //println(url)
        var nsUrl:NSURL=NSURL(string:url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        var request:NSURLRequest=NSURLRequest(URL:nsUrl)
        
        // send request
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            
            if httpResponse.statusCode == 200 {
                var recieveString:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var strArr:NSArray = recieveString.componentsSeparatedByString("<![CDATA[") as NSArray
                if strArr.count > 2{
                    var s1:NSString = strArr[1].description
                    s1 = s1.stringByReplacingOccurrencesOfString("]]></encode><decode>", withString: "")
                    var sArr:NSArray = s1.componentsSeparatedByString("/") as NSArray
                    var lastS:NSString = sArr.lastObject as! NSString
                    
                    var s2Arr:NSArray = strArr[2].description.componentsSeparatedByString("]]") as NSArray
                    
                    s1 = s1.stringByReplacingOccurrencesOfString(lastS as String, withString:s2Arr[0] as! NSString as String)
                    
                    //println(s1)
                    
                    self.audioPlayer.contentURL=NSURL(string: s1 as String)
                    
                    self.audioPlayer.play()
                    
                } else {
                
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        println(currentSong.songName)
        loadSong()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
