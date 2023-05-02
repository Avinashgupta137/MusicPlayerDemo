//
//  MusicViewController.swift
//  muSicPlayer
//
//  Created by IPS-149 on 02/05/23.
//

import UIKit
import AVFoundation

class SongDetailViewController: UIViewController {
    
    var player = AVAudioPlayer()
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var progressMusic: UISlider!
    @IBOutlet weak var startPlayTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            self?.updatePlayTimeLabel()
        }
        
    }
    func setupPlayer() {
        guard let url = Bundle.main.url(forResource: "man", withExtension: "mp3") else {
            print("Error: audio file not found")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback)
        } catch {
            print("Error: could not create audio player")
        }
    }
    
    
    func updatePlayTimeLabel() {
        let currentTime = Int(player.currentTime)
        let minutes = currentTime / 60
        let seconds = currentTime % 60
        let normalizedTime = Float(player.currentTime / player.duration)
        progressMusic.setValue(normalizedTime, animated: true)
        startPlayTime.text = String(format: "%02d:%02d", minutes, seconds)
    }
    //    Play
    @IBAction func play(_ sender: Any) {
        if !player.isPlaying {
            player.play()
        }
    }
    
    //    Pause
    @IBAction func pause(_ sender: Any) {
        if player.isPlaying {
            player.pause()
        }
    }
    
    //    Restart
    @IBAction func restart(_ sender: Any) {
        player.currentTime = 0
    }
    
    @IBAction func progressMusicChanged(_ sender: Any) {
        player.currentTime = TimeInterval(progressMusic.value) * player.duration
    }

    
}

extension SongDetailViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            progressMusic.value = 0
            updatePlayTimeLabel()
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Error: audio player decoding error occurred")
    }
}
