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
        // this was truly terrible
//        if(music.isPaused){return}
//        let elemnt = ((0...song.count).randomElement() ?? 0)
//        let utterance = AVSpeechUtterance(string: song.randomElement() ?? "")
//        utterance.voice =  voice
//        let types:[Float] = [0.5, 0.6, 0.6, 0.9, 0.618]
//        let pause:[Float] = [0.1, 0.0, 0.05, 0.09, 0.001]
//        utterance.rate = types.randomElement() ?? 1.0
//        utterance.pitchMultiplier = 0.5 + (Float(elemnt) / Float(song.count))
//        utterance.postUtteranceDelay = 0
//        print("\(utterance.rate), \(utterance.pitchMultiplier)Saying: \(utterance.speechString)")
//        music.speak(utterance)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute:{
//           self.randomSong()
//        }
//
//        )
       
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
