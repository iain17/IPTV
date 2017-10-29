//
//  PLayerViewController2.swift
//  IPTV
//
//  Created by Iain Munro on 29/10/2017.
//  Copyright © 2017 Iain Munro. All rights reserved.
//

import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open func play(_ url: URL) {
        self.player = AVPlayer(url: url)
        self.player?.play()
    }
}
