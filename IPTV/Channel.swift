//
//  Channel.swift
//  IPTV
//
//  Created by Iain Munro on 02/04/2017.
//  Copyright © 2017 Iain Munro. All rights reserved.
//

import Foundation

class Channel {
    var name: String
    var url: URL
    var icon: URL?
    var priority: Int
    
    init(name:String, url:URL, icon:URL?, priority:Int) {
        self.name = name
        self.url = url
        self.icon = icon
        self.priority = priority
    }
}
