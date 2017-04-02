//
//  ChannelTableCell.swift
//  IPTV
//
//  Created by Iain Munro on 02/04/2017.
//  Copyright © 2017 Larry Gadea. All rights reserved.
//

import Foundation
import UIKit

class ChannelTableCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func render(channel: Channel) {
        name.text = channel.name
        //TODO: icon. cache.
    }
    
}
