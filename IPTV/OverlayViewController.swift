//
//  playerViewController.swift
//  TVTestApp
//
//  Created by Iain Munro on 01/04/2017.
//  Copyright © 2017 Iain Munro. All rights reserved.
//

import Foundation
import UIKit
import Player

class OverlayViewController : UIViewController, UITableViewDelegate, PlayerDelegate, PlayerPlaybackDelegate {
    func playerReady(_ player: Player) {
        print("mua")
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        print(player.bufferingState)
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        print("e")
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        print("d")
    }
    
    func playerCurrentTimeDidChange(_ player: Player) {
        print("c")
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        print("v")
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        print("text")
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
        print("a")
    }
    
    
    var dataSource: ChannelTableViewDataSource?
    
    @IBOutlet weak var channelsTableView: UITableView!
    
    var player:Player?
    
    @IBOutlet weak var playerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.player = Player()
        self.player?.playerDelegate = self
        self.player?.playbackDelegate = self
        self.player?.view.frame = self.view.bounds
        
        self.addChildViewController(self.player!)
        self.view.addSubview(self.player!.view)
        self.player?.didMove(toParentViewController: self)
        
        view.bringSubview(toFront: channelsTableView)
        
        self.dataSource = ChannelTableViewDataSource(tableView: self.channelsTableView)
        channelsTableView.dataSource = self.dataSource
        channelsTableView.delegate = self
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(openMenu(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(closeMenu(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        //TODO: Make it remember the last channel
        play((dataSource?.channels[0].url)!)
    }
    
    func play(_ url:URL) {
        player?.url = url
        self.player?.playFromBeginning()
        closeMenu(gesture: UIGestureRecognizer(target: nil, action: nil))
    }
    
    // Called after the user changes the selection.
    @available(tvOS 2.0, *)
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let channel = dataSource?.channels[indexPath.row] {
            play(channel.url)
        }
    }
    
    @objc func closeMenu(gesture: UIGestureRecognizer) {
        UIView.animate(withDuration: 1, animations: {
            self.channelsTableView.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width / 3,height: UIScreen.main.bounds.size.height)
            self.channelsTableView.layoutIfNeeded()
        })
    }
    
    @objc func openMenu(gesture: UIGestureRecognizer) {
        UIView.animate(withDuration: 1, animations: {
            self.channelsTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 3,height: UIScreen.main.bounds.size.height)
            self.channelsTableView.layoutIfNeeded()
        })
    }
    
}
