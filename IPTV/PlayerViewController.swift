//
//  AvPlayerViewController.swift
//  IPTV
//
//  Created by Iain Munro on 02/09/2017.
//  Copyright © 2017 Iain Munro. All rights reserved.
//

import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let player = AVPlayer(playerItem: nil)
    }
    
    open func play(_ url: URL) {
        DispatchQueue.main.async {
            self.player?.replaceCurrentItem(with: AVPlayerItem(url: url))
            self.player?.play()
        }
//        DispatchQueue.main.async {
//            if self.player == nil {
//                self.player = AVPlayer(url: url)
//                self.videoGravity = AVLayerVideoGravityResizeAspectFill
//    //            let playerLayer = AVPlayerLayer(player: self.player)
//    //            playerLayer.frame = self.view.bounds
//    //            playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
//    //            self.view.layer.addSublayer(playerLayer)
//            } else {
//                self.player?.replaceCurrentItem(with: AVPlayerItem(url: url))
//            }
//    //        self.view.layer.frame = CGRect(0, 0, self.view.frame.size.width, self.view.frame.size.height)
//            self.player?.play()
//        }
    }

}
