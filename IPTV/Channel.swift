//
//  Channel.swift
//  IPTV
//
//  Created by Iain Munro on 02/04/2017.
//  Copyright © 2017 Larry Gadea. All rights reserved.
//

import Foundation

class Channel {
    var name: String
    var url: URL
    
    init(name:String, url:URL) {
        self.name = name
        self.url = url
    }
}
