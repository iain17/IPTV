//
//  playerViewController.swift
//  TVTestApp
//
//  Created by Iain Munro on 01/04/2017.
//  Copyright © 2017 Iain Munro. All rights reserved.
//

import Foundation
import UIKit

class OverlayViewController : UIViewController, UITableViewDelegate {
    var dataSource: ChannelTableViewDataSource?
    
    @IBOutlet weak var channelsTableView: UITableView!
    
    @IBOutlet weak var containerViewPlayer: UIView!
    
    var playerViewController: PlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        openMenu(gesture: UIGestureRecognizer(target: nil, action: nil))
    }
    
    func play(_ url:URL) {
        self.playerViewController?.play(url)
        closeMenu(gesture: UIGestureRecognizer(target: nil, action: nil))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "player" {
            self.playerViewController = segue.destination as? PlayerViewController
        }
    }
    
    // Called after the user changes the selection.
    @available(tvOS 2.0, *)
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let channel = dataSource?.channels[indexPath.row] {
            play(channel.url)
        }
    }
    
    @objc func closeMenu(gesture: UIGestureRecognizer) {
        view.bringSubview(toFront: containerViewPlayer)
        UIView.animate(withDuration: 1, animations: {
            self.channelsTableView.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width / 3,height: UIScreen.main.bounds.size.height)
            self.channelsTableView.layoutIfNeeded()
        })
    }
    
    @objc func openMenu(gesture: UIGestureRecognizer) {
        view.bringSubview(toFront: channelsTableView)
        UIView.animate(withDuration: 1, animations: {
            self.channelsTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 3,height: UIScreen.main.bounds.size.height)
            self.channelsTableView.layoutIfNeeded()
        })
    }
    
}
