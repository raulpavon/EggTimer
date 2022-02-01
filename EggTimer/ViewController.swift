//
//  ViewController.swift
//  EggTimer
//
//  Created by Raúl Pavón on 31/01/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    let eggTimes = ["Soft": 3, "Medium": 420, "Hard": 720]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var totalTime = 0
    var secondPassed = 0
    var timer = Timer()
    
    @IBAction func hardOptional(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.titleLabel?.text ?? ""
        
        totalTime = eggTimes[hardness] ?? 0
        
        progressBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondPassed < totalTime {
            secondPassed += 1
            progressBar.progress = Float(secondPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playAlarm()
        }
    }
    
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}
