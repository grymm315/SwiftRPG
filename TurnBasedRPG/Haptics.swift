//
//  Feel.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 1/16/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import Foundation
import CoreHaptics

// This class is about Haptic touch events. It is originally a follow along project for WWDC 2023
// "Haptic Richochet" app- but I wanted something that felt a little more natural for me.

class Haptics {
    
    enum TouchType {
        case none
        case small
        case large
        case shield
    }
    
    private var touchState:TouchType = .none
    static let shared:Haptics = Haptics()
    
    private var engine: CHHapticEngine!
    private var engineNeedsStart = true
    
    
    private var smallTouch: CHHapticPatternPlayer!
    private var bigTouch: CHHapticPatternPlayer!
    private var trill: CHHapticPatternPlayer!
    
    lazy var supportsHaptics: Bool = {
        CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }()
    
    init() {
        createAndStartHapticEngine()
        initializeHaptics()
    }
    
    private func createAndStartHapticEngine() {
        guard supportsHaptics else { return }
        
        // Create and configure a haptic engine.
        do {
            engine = try CHHapticEngine(audioSession: .sharedInstance())
        } catch let error {
            fatalError("Engine Creation Error: \(error)")
        }
        
        // The stopped handler alerts engine stoppage.
        engine.stoppedHandler = { reason in
            print("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
            switch reason {
            case .audioSessionInterrupt:
                print("Audio session interrupt.")
            case .applicationSuspended:
                print("Application suspended.")
            case .idleTimeout:
                print("Idle timeout.")
            case .notifyWhenFinished:
                print("Finished.")
            case .systemError:
                print("System error.")
            case .engineDestroyed:
                print("Engine destroyed.")
            case .gameControllerDisconnect:
                print("Controller disconnected.")
            @unknown default:
                print("Unknown error")
            }
            
            // Indicate that the next time the app requires a haptic, the app must call engine.start().
            self.engineNeedsStart = true
        }
        
        // The reset handler notifies the app that it must reload all of its content.
        // If necessary, it recreates all players and restarts the engine in response to a server restart.
        engine.resetHandler = {
            print("The engine reset --> Restarting now!")
            
            // Tell the app to start the engine the next time a haptic is necessary.
            self.engineNeedsStart = true
        }
        
        // Start the haptic engine to prepare it for use.
        do {
            try engine.start()
            
            // Indicate that the next time the app requires a haptic, the app doesn't need to call engine.start().
            engineNeedsStart = false
        } catch let error {
            print("The engine failed to start with error: \(error)")
        }
    }
    
    func initializeHaptics() {
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        
        let long2 = CHHapticEvent(eventType: .hapticContinuous, parameters: [], relativeTime: 1.2, duration: 0.5)

        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        
        var trillEvents = [CHHapticEvent]()

           for i in stride(from: 0, to: 1, by: 0.1) {
               let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
               let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
               let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i/8)
               trillEvents.append(event)
           }
        
        do {
            let collisionPatternSmall = try CHHapticPattern(events: [event], parameters: [])
            smallTouch = try? self.engine.makePlayer(with: collisionPatternSmall)
            let big = try CHHapticPattern(events: [long2,event,long2], parameters: [])
            bigTouch = try? self.engine.makePlayer(with: big)
            let trillio = try CHHapticPattern(events: trillEvents, parameters: [])
            trill = try? self.engine.makePlayer(with: trillio)

           } catch {
               print("Failed to play pattern: \(error.localizedDescription).")
           }
        
    }
    
    func lilTouch() {
        //this is more of a *tonk*
        feel(smallTouch)
    }
    
    func longTouch() {
        //this is more of a *chink* sound
        feel(bigTouch)
    }
    
    func trillTouch(){
        feel(trill)
    }
   
    
    func feel(_ pattern: CHHapticPatternPlayer) {
        guard supportsHaptics else { return }
        do {
            try startHapticEngineIfNecessary()
            try pattern.start(atTime: CHHapticTimeImmediate)
        } catch let error {
            print("Error starting haptic player: \(error)")
        }
    }
    
    func stopPlayer(_ player: CHHapticPatternPlayer) {
        guard supportsHaptics else { return }
        
        do {
            try startHapticEngineIfNecessary()
            try player.stop(atTime: CHHapticTimeImmediate)
        } catch let error {
            print("Error stopping haptic player: \(error)")
        }
    }
    
    private func linearInterpolation(alpha: Float, min: Float, max: Float) -> Float {
        return min + alpha * (max - min)
    }
    
    func playCollisionHaptic(_ normalizedMagnitude: Float) {
        do {
            // Create dynamic parameters for the current magnitude.
            let intensityValue = linearInterpolation(alpha: normalizedMagnitude, min: 0.375, max: 1.0)
            let intensityParameter = CHHapticDynamicParameter(parameterID: .hapticIntensityControl,
                                                              value: intensityValue,
                                                              relativeTime: 0)
            let volumeValue = linearInterpolation(alpha: normalizedMagnitude, min: 0.1, max: 1.0)
            let volumeParameter = CHHapticDynamicParameter(parameterID: .audioVolumeControl,
                                                              value: volumeValue,
                                                              relativeTime: 0)

            try startHapticEngineIfNecessary()

            switch touchState {
            case .small:
                try smallTouch.sendParameters([intensityParameter, volumeParameter], atTime: CHHapticTimeImmediate)
                try smallTouch.start(atTime: CHHapticTimeImmediate)
            case .large:
                try bigTouch.sendParameters([intensityParameter, volumeParameter], atTime: CHHapticTimeImmediate)
                try bigTouch.start(atTime: CHHapticTimeImmediate)
       
            default:
                print("No action for the collision during: \(touchState)")
            }
        } catch let error {
                print("Haptic Playback Error: \(error)")
        }
    }
    
    func startHapticEngineIfNecessary() throws {
        if engineNeedsStart {
            try engine.start()
            engineNeedsStart = false
        }
    }
    
    func restartHapticEngine() {
        self.engine.start { error in
            if let error = error {
                print("Haptic Engine Startup Error: \(error)")
                return
            }
            self.engineNeedsStart = false
        }
    }
    
    func stopHapticEngine() {
        self.engine.stop { error in
            if let error = error {
                print("Haptic Engine Shutdown Error: \(error)")
                return
            }
            self.engineNeedsStart = true
        }
    }
    
}
