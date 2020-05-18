//
//  MediaPlayerController.swift
//  OBSPattern
//
//  Created by MattHew Phraxayavong on 4/8/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

//error handling

enum MyError: Error {
    case FoundNil(String)
}

protocol startAVCommand {
    func execute()
}

// Receiver
struct AVPlayerControl {
    var shared: AVAudioPlayer?
    
}

class PlayCommand: startAVCommand {
    public let  musicPlayerControl: MediaControlTower
    public init(_ musicPlayerControl: MediaControlTower) {
        self.musicPlayerControl = musicPlayerControl
    }
    public func execute() {
        print("executing start")
        musicPlayerControl.play()
    }
}

class PauseCommand: startAVCommand {
    public let musicPlayerControl: MediaControlTower
    public init(_ musicPlayerControl: MediaControlTower) {
        self.musicPlayerControl = musicPlayerControl
    }
    
    public func execute() {
        print("executing pause")
        musicPlayerControl.pause()
    }
}

class RestartCommand: startAVCommand {
    let musicPlayerControl: AVPlayerControl
    
    init(_ musicPlayerControl: AVPlayerControl) {
        self.musicPlayerControl = musicPlayerControl
    }
    func execute() {
    }
}

//Controller
class MediaControlTower {
    let songs: [String] = ["lala"]
    var currentSongsIndex: Int = 0
    var audioPlayer = AVAudioPlayer()
    
    func play() {
        let sound = URL(fileURLWithPath: Bundle.main.path(forResource: songs[currentSongsIndex], ofType: "mp3")!)
        do {
            print("something is playing")
            if audioPlayer == nil {
                audioPlayer = try AVAudioPlayer(contentsOf: sound)
            }
            DispatchQueue.main.async {
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func pause() {
        audioPlayer.pause()
        print("something has been paused")
    }
    
    func restart() {
        print("restarting")
    }
    
    func nextSong() {
        print("next")
    }
}


class MediaInvoker {
    public let musicControl: MediaControlTower
    
    init(_ musicControl: MediaControlTower) {
        self.musicControl = musicControl
    }
    
    func execute(_ command: startAVCommand) {
        print("invoke started")
        command.execute()
    }
}
