//
//  AvPlayerViewController.swift
//  IPTV
//
//  Created by Iain Munro on 02/09/2017.
//  Copyright © 2017 Iain Munro. All rights reserved.
//

import UIKit
import Player

class PlayerViewController: UIViewController, PlayerDelegate, PlayerPlaybackDelegate {
    var player:Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.player = Player()
        self.player?.playerDelegate = self
        self.player?.playbackDelegate = self
        self.player?.view.frame = self.view.bounds
        
        self.addChildViewController(self.player!)
        self.view.addSubview(self.player!.view)
        self.player?.didMove(toParentViewController: self)
    }
    
    open func play(_ url: URL) {
        self.player?.url = url
    }
    
    func playerReady(_ player: Player) {
        print("test")
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
    
    func playerCurrentTimeDidChange(_ player: Player) {
        
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
        
    }

}
