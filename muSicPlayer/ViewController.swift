//
//  ViewController.swift
//  muSicPlayer
//
//  Created by IPS-149 on 02/05/23.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startPlayTime: UILabel!
    @IBOutlet weak var progressMusic: UIProgressView!
    @IBOutlet weak var btnMusic: UIButton!
    
    var updater : CADisplayLink! = nil
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func pause(_ sender: Any) {
            if player != nil {
                player.stop()
                player = nil
                btnMusic.setImage(UIImage(named: "play"), for: .normal)
            } else {
                btnMusic.setImage(UIImage(named: "pause"), for: .normal)
                playSound()
                updater = CADisplayLink(target: self, selector: #selector(self.musicProgress))
                updater.frameInterval = 1
                updater.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
                
                
            }
        }

    func playSound() {
           let url = Bundle.main.url(forResource: "MusicDemo1", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
           player.play()
       // startPlayTime.text = "\(player.currentTime)"
        }
    @objc func musicProgress()  {
        guard let player = player else {
            return
        }
        let normalizedTime = Float(player.currentTime * 100.0 / player.duration)
        startPlayTime.text = "\(player.currentTime)"
        progressMusic.setProgress(normalizedTime/100.0, animated: true)
    }


}
