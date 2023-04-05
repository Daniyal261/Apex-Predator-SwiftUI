//
//  PredatorDetailController.swift
//  Apex Predators
//
//  Created by Raja Adeel Ahmed on 4/5/23.
//

import Foundation
import AVFoundation

class PredatorDetailController {
    
    let synthesizer = AVSpeechSynthesizer()
    var audioPlayer: AVAudioPlayer?
    var isPlaying = false

    func speak(_ string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact")
            utterance.rate = 0.5
            utterance.pitchMultiplier = 1.2
            utterance.volume = 1.0
        synthesizer.speak(utterance)
    }
    
    func getIsPlaying()->Bool {
        return isPlaying
    }
    
    func playSound(_ soundName:String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        do {
           
            if(!isPlaying) {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                try AVAudioSession.sharedInstance().setActive(true)
                
                audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                
                guard let player = audioPlayer else { return }
                
                player.play()
            } else {
                if(audioPlayer != nil) {
                    audioPlayer?.stop()
                }
            }
            isPlaying.toggle()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
