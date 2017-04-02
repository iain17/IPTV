//
//  ChannelTableViewDataSource.swift
//  IPTV
//
//  Created by Iain Munro on 02/04/2017.
//  Copyright © 2017 Iain Munro. All rights reserved.
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
            self.channels = self.channels.sorted(by: { $0.priority < $1.priority })
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
        var title = segment.title!
        var path = segment.path!
        var priority = 0
        
        //Only Dutch, British and VOD channels.
        if let properties = segment.properties {
            if let group = properties["group-title"] {
                switch group {
                case "Nederland":
                    priority = 10
                    if title.contains("NPO") {
                        priority = 1
                    }
                    if title.contains("RTL") {
                        priority = 9
                    }
                    break
                case "British":
                    priority = 20
                    if title.contains("Daave") {
                        priority = 15
                    }
                    if title.contains("BBC") {
                        priority = 18
                    }
                    break
                case "France":
                    priority = 30
                    break
                case "Germany & Austria":
                    priority = 40
                    break
                case "Switzerland":
                    priority = 50
                    break
                default:
                    break
                }
            }
        }
        
        if priority == 0 {
            return
        }
        
        //Remove country seperator.
        if title.hasPrefix("===") {
            return
        }
        
        //If the channel is not 1080p, ignore it if it isn't dave.
        if !title.contains("1080P") &&
            ( !title.contains("Dave")
        ) {
            return
        }
        
        var logo:URL?
        if let properties = segment.properties {
            if let logoRaw = properties["tvg-logo"] {
                logo = URL(string: logoRaw)
            }
        }
    
        let url = URL(string: path)
        if url == nil {
            return
        }
        title = title.replacingOccurrences(of: "1080P", with: "")
        title = title.replacingOccurrences(of: " HD", with: "")
        title = title.replacingOccurrences(of: "VIP UK:", with: "")
        title = title.replacingOccurrences(of: "UK:", with: "")
        title = title.replacingOccurrences(of: "NL:", with: "")
        
        let channel = Channel(name: title, url: url!, icon: logo, priority: priority)
        self.channels.append(channel)
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
