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
    private func playVoicemail(){AudioServicesPlaySystemSound(1002)}
    private func receivedMessage(){AudioServicesPlaySystemSound(1003)}
    private func alarm(){AudioServicesPlaySystemSound(1005)}
    private func lowPower(){AudioServicesPlaySystemSound(1006)}
    private func bloom(){AudioServicesPlaySystemSound(1021)}
    private func anticipate(){AudioServicesPlaySystemSound(1020)}
    private func calypso(){AudioServicesPlaySystemSound(1022)}
    private func choochoo(){AudioServicesPlaySystemSound(1023)}
    private func descent(){AudioServicesPlaySystemSound(1024)}
    private func fanfare(){AudioServicesPlaySystemSound(1025)}
    private func ladder(){AudioServicesPlaySystemSound(1026)}
    private func minuet(){AudioServicesPlaySystemSound(1027)}
    private func newsflash(){AudioServicesPlaySystemSound(1028)}
    private func noir(){AudioServicesPlaySystemSound(1029)}
    private func sherwoodforest(){AudioServicesPlaySystemSound(1030)}
    private func spell(){AudioServicesPlaySystemSound(1031)}
    private func suspense(){AudioServicesPlaySystemSound(1032)}
    private func telegraph(){AudioServicesPlaySystemSound(1033)}
    private func tiptoes(){AudioServicesPlaySystemSound(1034)}
    private func typewriters(){AudioServicesPlaySystemSound(1035)}
    private func updates(){AudioServicesPlaySystemSound(1036)}
    private func whoohn(){AudioServicesPlaySystemSound(1050)}
    private func lock(){AudioServicesPlaySystemSound(1100)}
    private func unlock(){AudioServicesPlaySystemSound(1101)}
    private func failUnlock(){AudioServicesPlaySystemSound(1102)}
    private func tink(){AudioServicesPlaySystemSound(1103)}
    private func tock(){AudioServicesPlaySystemSound(1104)}
    private func beepbeep(){AudioServicesPlaySystemSound(1106)}
    private func photoshutter(){AudioServicesPlaySystemSound(1108)}
    private func ringerchanged(){AudioServicesPlaySystemSound(1107)}
    private func shake(){AudioServicesPlaySystemSound(1109)}
    private func whoosh(){AudioServicesPlaySystemSound(1055)}

    let meep = AVPlayer()
    let music = AVSpeechSynthesizer()
    
    let synth = AVSpeechSynthesizer()
    let voice = AVSpeechSynthesisVoice(language: "en-IE")
    
    
    func speak(_ text: String){
                let utterance = AVSpeechUtterance(string: text)
                utterance.voice = voice
                utterance.rate = 0.55
                utterance.pitchMultiplier = 0.6
                print("Saying: \(utterance.speechString)")
                synth.speak(utterance)
    }
    
    func tapSound() {
        tink()
        Haptics.shared.lilTouch()
    }
    
    func roomChangeSound(){
        Haptics.shared.trillTouch()
    }
    
    func menuOpen(){
        
    }
    
    func noPassage(){
        tock()
    }
    
    
    func pauseMusic() {
        music.pauseSpeaking(at: .immediate)
    }
    
    func randomSong(){
        
    }
    
    func magic(){
    }
    
    func painNoise(){
        tink()
        Haptics.shared.longTouch()
    }
    
    
    
    
}
