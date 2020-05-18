//
//  CommandPatternMP.swift
//  OBSPattern
//
//  Created by MattHew Phraxayavong on 4/13/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import UIKit
import AVFoundation

class CommandViewController: UIViewController {
    var audioPlayer = MediaControlTower()
    var invoker: MediaInvoker!
    var isPlaying = false
    var timer:Timer!
    let playList: [String] = ["bbsremix"]
    var trackTitle: UILabel!
    var playedTime: UILabel!
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "playpause")
        button.frame = CGRect(x: 50, y: 50, width: 400, height: 500)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.shadowColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 30, height: 2.0)
        button.setTitleColor(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), for: .normal)
        button.setTitle("Play", for: .normal)
        button.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
        
        
        return button
    }()
    @objc func pressed(sender: UIButton!) {
        
        let play = PlayCommand(audioPlayer)
        let pause = PauseCommand(audioPlayer)
        
        if isPlaying {
            invoker.execute(pause)
            isPlaying = false
            playButton.setTitle("Play", for: .normal)
            print("isplaying is false")
        } else {
            invoker.execute(play)
            isPlaying = true
            playButton.setTitle("Pause", for: .normal)
            print("isplaying is true")
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(playButton)
        invoker = MediaInvoker(audioPlayer)
        
    }
}
