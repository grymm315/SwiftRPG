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
    
    static let shared:SoundController = SoundController()
    
    // Adding generic system sounds so I don't need a lookup chart
    func playVoicemail(){AudioServicesPlaySystemSound(1002)}
    func receivedMessage(){AudioServicesPlaySystemSound(1003)}
    func alarm(){AudioServicesPlaySystemSound(1005)}
    func lowPower(){AudioServicesPlaySystemSound(1006)}
    func bloom(){AudioServicesPlaySystemSound(1021)}
    func anticipate(){AudioServicesPlaySystemSound(1020)}
    func calypso(){AudioServicesPlaySystemSound(1022)}
    func choochoo(){AudioServicesPlaySystemSound(1023)}
    func descent(){AudioServicesPlaySystemSound(1024)}
    func fanfare(){AudioServicesPlaySystemSound(1025)}
    func ladder(){AudioServicesPlaySystemSound(1026)}
    func minuet(){AudioServicesPlaySystemSound(1027)}
    func newsflash(){AudioServicesPlaySystemSound(1028)}
    func noir(){AudioServicesPlaySystemSound(1029)}
    func sherwoodforest(){AudioServicesPlaySystemSound(1030)}
    func spell(){AudioServicesPlaySystemSound(1031)}
    func suspense(){AudioServicesPlaySystemSound(1032)}
    func telegraph(){AudioServicesPlaySystemSound(1033)}
    func tiptoes(){AudioServicesPlaySystemSound(1034)}
    func typewriters(){AudioServicesPlaySystemSound(1035)}
    func updates(){AudioServicesPlaySystemSound(1036)}
    func whoohn(){AudioServicesPlaySystemSound(1050)}
    func lock(){AudioServicesPlaySystemSound(1100)}
    func unlock(){AudioServicesPlaySystemSound(1101)}
    func failUnlock(){AudioServicesPlaySystemSound(1102)}
    func tink(){AudioServicesPlaySystemSound(1103)}
    func tock(){AudioServicesPlaySystemSound(1104)}
    func beepbeep(){AudioServicesPlaySystemSound(1106)}
    func photoshutter(){AudioServicesPlaySystemSound(1108)}
    func ringerchanged(){AudioServicesPlaySystemSound(1107)}
    func shake(){AudioServicesPlaySystemSound(1109)}
    func whoosh(){AudioServicesPlaySystemSound(1055)}

    
    
    let synth = AVSpeechSynthesizer()
    let music = AVSpeechSynthesizer()
    let voice = AVSpeechSynthesisVoice(language: "en-IE")
    
    let meep = AVPlayer()
    
    func speak(_ text: String){
                let utterance = AVSpeechUtterance(string: text)
                utterance.voice = voice
                utterance.rate = 0.55
                utterance.pitchMultiplier = 0.6
                print("Saying: \(utterance.speechString)")
                synth.speak(utterance)
    }
    
    func randomInsults(){
        tink()
    }
    
    func pauseMusic() {
        music.pauseSpeaking(at: .immediate)
    }
    
    func randomSong(){
        
    }
    
    func magic(){
       spell()
    }
    
    func painNoise(){
        tock()
        
    }
    
    
    
    
}
