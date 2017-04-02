//
//  ChannelTableViewDataSource.swift
//  IPTV
//
//  Created by Iain Munro on 02/04/2017.
//  Copyright © 2017 Larry Gadea. All rights reserved.
//

import Foundation
import UIKit
import Pantomime

class ChannelTableViewDataSource: NSObject, UITableViewDataSource {
   
    var playlist: MediaPlaylist?
    var tableView: UITableView
    public var channels: [Channel]
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.channels = [Channel]()
        super.init()
        buildChannelList()
    }
    
    func buildChannelList() {
        loadPlayList()
        defer {
            self.tableView.reloadData()
        }
        self.channels.removeAll()
        if let playlist = self.playlist {
            for i in 0...playlist.getSegmentCount() {
                if let segment = playlist.getSegment(i) {
                    addChannel(segment)
                }
            }
        }
    }
    //Adds a channel. Contains the logic showing only relevant channels.
    func addChannel(_ segment: MediaSegment) {
        if segment.title == nil || segment.path == nil {
            return
        }
        var vod = false
        //Only Dutch, British and VOD channels.
        if let properties = segment.properties {
            if let group = properties["group-title"] {
                vod = group.hasPrefix("VOD:")
                if group != "Nederland" && group != "British" && !vod {
                    return
                }
            } else {
                return
            }
        } else {
            return
        }
        
        //Remove country seperator.
        if let title = segment.title {
            if title.hasPrefix("===") {
                return
            }
            
            //If the channel is not 1080p, ignore it if it isn't dave or a vod.
            if !title.contains("1080P") &&
                ( !title.contains("Dave") && !vod) {
                return
            }
        }
        
        let url = URL(string: segment.path!)
        if url == nil {
            return
        }
        
        let channel = Channel(name: segment.title!, url: url!)
        self.channels.append(channel)
        //self.channels.append(Channel(name: (segment?.title)!))
    }
    
    func loadPlayList() {
        let builder = ManifestBuilder()
        if let url = URL(string: playlistUrl) {
            playlist = builder.parseMediaPlaylistFromURL(url)
        }
    }
    
    @available(tvOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let channel = channels[indexPath.row] as? Channel {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelTableCell {
                cell.render(channel: channel)
                return cell
            }
        }
        
        return UITableViewCell()
    }

    @available(tvOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    @available(tvOS 2.0, *)
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }

}
