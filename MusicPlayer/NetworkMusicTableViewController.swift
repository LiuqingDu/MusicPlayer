//
//  NetworkMusicTableViewController.swift
//  MusicPlayer
//
//  Created by Liuqing Du on 13/04/2015.
//  Copyright (c) 2015 JuneDesign. All rights reserved.
//

import UIKit

class NetworkMusicTableViewController: UITableViewController {

    var songList: Array<Song> = []
    var currentSong: Song!
    
    /*
    func loadChannelList() {
        
        let url = NSURL(string: "https://gitcafe.com/wcrane/XXXYYY/raw/master/baidu.json")
        let request = NSURLRequest(URL: url!)
        
        // send request
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            
            if httpResponse.statusCode == 200 {
                // serialize json to array
                let array: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSArray
                
                for dict in array {
                    var channel = Channel(dict: dict as! NSDictionary)
                    self.channelList.append(channel)
                }
                
                self.tableView.reloadData()
                
            } else {
                
            }
        }
        
    }
*/
    
    func loadSongList() {
        
        let url = NSURL(string: "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billList&type=21&page_no=1&page_size=50&scene_id=42&item_id=115&version=5.2.1&from=ios&channel=appstore")
        let url2 = NSURL(string: "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getSmartSongList&page_no=1&page_size=50&scene_id=42&item_id=115&version=5.2.1&from=ios&channel=appstore")
        let request = NSURLRequest(URL: url!)
        
        // send request
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            
            if httpResponse.statusCode == 200 {
                // serialize json to array
                let dict: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                //let di: NSDictionary = dict["result"] as! NSDictionary
                
                let list: NSArray = dict["song_list"] as! NSArray
                for d in list {
                    var song = Song()
                    song.songName = d["title"] as! NSString
                    song.artistName = d["author"] as! NSString
                    self.songList.append(song)
                }
                
                self.tableView.reloadData()
                
            } else {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // get song list
        loadSongList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.songList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        
        let song: Song = self.songList[indexPath.row]
        cell.textLabel!.text = song.songName as String

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        currentSong = self.songList[indexPath.row]
        
        return indexPath
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        var destViewCountroller: NetworkMusicViewController = segue.destinationViewController as! NetworkMusicViewController
        destViewCountroller.currentSong = currentSong
    }

}
