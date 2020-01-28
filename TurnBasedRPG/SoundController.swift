//
//  SoundController.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 9/29/19.
//  Copyright © 2019 Chris Phillips. All rights reserved.
//

import Foundation
import AVFoundation

class SoundController {
    
    let synth = AVSpeechSynthesizer()
    let music = AVSpeechSynthesizer()
    let voice = AVSpeechSynthesisVoice(language: "en-IE")
    
    let meep = AVPlayer()
    
    let insults = [
        "Ye! YA!",
        "ARG",
        "Coo sew",
        "Ah",
        
        ]
    
    let painString = [
        "Ga",
        "Aaaa",
        "Fuh"
    ]
    
    let song = [
    "do", "re", "Mi", "sew", "la", "ti"
    
    ]
    
    func randomInsults(){
        let utterance = AVSpeechUtterance(string: insults.randomElement() ?? "Oh Shit")
        utterance.voice = voice
        utterance.rate = 0.55
        utterance.pitchMultiplier = 0.6
        print("Saying: \(utterance.speechString)")
        synth.speak(utterance)
        
    }
    
    func pauseMusic() {
        music.pauseSpeaking(at: .immediate)
    }
    
    func randomSong(){
       
    }
    
    func magic(){
        let ma = AVSpeechUtterance(string: "DDD")
        ma.voice = voice
        ma.rate = 1.09
        ma.pitchMultiplier = 1.5
        synth.speak(ma)
    }
    
    func painNoise(){
        let utterance = AVSpeechUtterance(string: painString.randomElement() ?? "Oh Shit")
        utterance.voice = voice
        utterance.rate = 0.77
        utterance.pitchMultiplier = 0.5
        print("Saying: \(utterance.speechString)")
        synth.speak(utterance)
        
    }
    

    
    
}
