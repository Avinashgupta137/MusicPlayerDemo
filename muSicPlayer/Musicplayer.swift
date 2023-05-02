import UIKit
import AVFoundation

class SongViewController: UIViewController {
    
    var player: AVPlayer?
    
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
        guard let url = URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3") else {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }
     
    func updatePlayTimeLabel() {
        guard let player = player else {
            return
        }
        let currentTime = Int(player.currentTime().seconds)
        let minutes = currentTime / 60
        let seconds = currentTime % 60
        let normalizedTime = Float(player.currentTime().seconds / (player.currentItem?.duration.seconds)! ?? 1.0)
        progressMusic.setValue(normalizedTime, animated: true)
        startPlayTime.text = String(format: "%02d:%02d", minutes, seconds)
    }
    //    Play
    @IBAction func play(_ sender: Any) {
        if let player = player {
            player.play()
        }
    }
    
    //    Pause
    @IBAction func pause(_ sender: Any) {
        if let player = player {
            player.pause()
        }
    }
    
    //    Restart
    @IBAction func restart(_ sender: Any) {
        guard let player = player else {
            return
        }
        player.seek(to: CMTime(seconds: 0.0, preferredTimescale: 1))
    }
    
    @IBAction func progressMusicChanged(_ sender: Any) {
        guard let player = player else {
            return
        }
        player.seek(to: CMTime(seconds: Double(progressMusic.value) * (player.currentItem?.duration.seconds ?? 1.0), preferredTimescale: 1))
    }

    
}
