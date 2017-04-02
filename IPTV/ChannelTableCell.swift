//
//  ChannelTableCell.swift
//  IPTV
//
//  Created by Iain Munro on 02/04/2017.
//  Copyright © 2017 Iain Munro. All rights reserved.
//

import Foundation
import UIKit

class ChannelTableCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func render(channel: Channel) {
        name.text = channel.name
        if let iconUrl = channel.icon {
            icon.cacheSetImageFromURL(iconUrl)
        } else {
            icon.image = nil
        }
    }
    
}
