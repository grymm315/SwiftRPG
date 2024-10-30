//
//  Particles.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 10/22/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import UIKit
class ParticleView: UIView {
    
    var northExit: NorthParticles?
    var southExit: SouthParticles?
    var eastExit: RightParticles?
    var westExit: LeftParticles?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.backgroundColor = UIColor.clear
        eastExit = RightParticles(rect: self.frame)
        westExit = LeftParticles(rect: self.frame)
        northExit = NorthParticles(rect: self.frame)
        southExit = SouthParticles(rect: self.frame)
        
        layer.addSublayer(southExit!)
        layer.addSublayer(northExit!)
        layer.addSublayer(eastExit!)
        layer.addSublayer(westExit!)
        
    }
    
    public func stopAll(){
        eastExit?.stop()
        westExit?.stop()
        northExit?.stop()
        southExit?.stop()
    }
    
    public func indicateSwipe(forRoom: RoomNode){
        if (forRoom.north != nil){
            northExit?.start()
        }
        if (forRoom.south != nil){
            southExit?.start()
        }
        if (forRoom.east != nil){
           eastExit?.start()
        }
        if (forRoom.west != nil){
            westExit?.start()
        }
    }
}



class RightParticles: CAEmitterLayer {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSwipeParticles(rect: CGRect(x: 0, y: 0, width: 1, height: 100))
    }
    
    init (rect: CGRect){
        super.init()
        setupSwipeParticles(rect: rect)
    }
    
    func setupSwipeParticles(rect: CGRect) {
            // Create and configure the emitter layer
            
        self.emitterPosition = CGPoint(x: rect.midX, y: rect.midY)
        self.emitterShape = .cuboid
        self.emitterSize = CGSize(width: rect.size.width / 4 , height: rect.size.height)
                                  
            // Create and configure the emitter cell
            let cell = CAEmitterCell()
            cell.contents = UIImage(systemName: "chevron.right")?.cgImage
            cell.color = UIColor(white: 1, alpha: 0).cgColor
            cell.alphaRange = 0
            cell.scale = 0.5
            cell.scaleRange = 0.2
            cell.lifetime = 2.0
            cell.birthRate = 1
            cell.velocity = 75
            cell.velocityRange = 25
            cell.emissionLongitude = 0
            cell.emissionRange = 0//.pi / 4
            cell.spin = 0
            cell.spinRange = 0
            cell.alphaSpeed = 0.1
            
            self.emitterCells = [cell]
            
        }
    
    public func start() {
        self.birthRate = 20
    }
    
    // Call this method when you want to stop the particle effect
    public func stop() {
        self.birthRate = 0
    }
}

class LeftParticles: CAEmitterLayer {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSwipeParticles(rect: CGRect(x: 0, y: 0, width: 1, height: 100))
    }
    
    init (rect: CGRect){
        super.init()
        setupSwipeParticles(rect: rect)
    }
    
    func setupSwipeParticles(rect: CGRect) {
            // Create and configure the emitter layer
            
        self.emitterPosition = CGPoint(x: rect.midX, y: rect.midY)
        self.emitterShape = .cuboid
        self.emitterSize = CGSize(width: rect.size.width / 4 , height: rect.size.height)
                                  
            // Create and configure the emitter cell
            let cell = CAEmitterCell()
            cell.contents = UIImage(systemName: "chevron.left")?.cgImage
            cell.color = UIColor(white: 1, alpha: 0).cgColor
            cell.alphaRange = 0
            cell.scale = 0.5
            cell.scaleRange = 0.2
            cell.lifetime = 2.0
            cell.birthRate = 1
            cell.velocity = -75
            cell.velocityRange = 25
            cell.emissionLongitude = 0
            cell.emissionRange = 0//.pi / 4
            cell.spin = 0
            cell.spinRange = 0
            cell.alphaSpeed = 0.1
            
            self.emitterCells = [cell]
            
        }
    
    public func start() {
        self.birthRate = 20
    }
    
    // Call this method when you want to stop the particle effect
    public func stop() {
        self.birthRate = 0
    }
}

class SouthParticles: CAEmitterLayer {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSwipeParticles(rect: CGRect(x: 0, y: 0, width: 1, height: 100))
    }
    
    init (rect: CGRect){
        super.init()
        setupSwipeParticles(rect: rect)
    }
    
    func setupSwipeParticles(rect: CGRect) {
            // Create and configure the emitter layer
            
        self.emitterPosition = CGPoint(x: rect.midX, y: rect.midY)
        self.emitterShape = .cuboid
        self.emitterSize = CGSize(width: rect.size.width / 4 , height: rect.size.height)
                                  
            // Create and configure the emitter cell
            let cell = CAEmitterCell()
            cell.contents = UIImage(systemName: "chevron.down")?.cgImage
            cell.color = UIColor(white: 1, alpha: 0).cgColor
            cell.alphaRange = 0
            cell.scale = 0.5
            cell.scaleRange = 0.2
            cell.lifetime = 2.0
            cell.birthRate = 1
    
            cell.velocity = -75
            cell.velocityRange = 25
            cell.emissionLongitude = -.pi / 2
            cell.emissionRange = 0//.pi / 4
            cell.spin = 0
            cell.spinRange = 0
            cell.alphaSpeed = 0.1
            
            self.emitterCells = [cell]
            
        }
    
    public func start() {
        self.birthRate = 20
    }
    
    // Call this method when you want to stop the particle effect
    public func stop() {
        self.birthRate = 0
    }
}

class NorthParticles: CAEmitterLayer {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSwipeParticles(rect: CGRect(x: 0, y: 0, width: 1, height: 100))
    }
    
    init (rect: CGRect){
        super.init()
        setupSwipeParticles(rect: rect)
    }
    
    func setupSwipeParticles(rect: CGRect) {
            // Create and configure the emitter layer
            
        self.emitterPosition = CGPoint(x: rect.midX, y: rect.midY)
        self.emitterShape = .cuboid
        self.emitterSize = CGSize(width: rect.size.width / 4 , height: rect.size.height)
                                  
            // Create and configure the emitter cell
            let cell = CAEmitterCell()
            cell.contents = UIImage(systemName: "chevron.up")?.cgImage
            cell.color = UIColor(white: 1, alpha: 0).cgColor
            cell.alphaRange = 0
            cell.scale = 0.5
            cell.scaleRange = 0.2
            cell.lifetime = 2.0
            cell.birthRate = 1

            cell.velocity = 75
            cell.velocityRange = 25
            cell.emissionLongitude = -.pi / 2
            cell.emissionRange = 0//.pi / 4
            cell.spin = 0
            cell.spinRange = 0
            cell.alphaSpeed = 0.1
            
            self.emitterCells = [cell]
            
        }
    
    public func start() {
        self.birthRate = 20
    }
    
    // Call this method when you want to stop the particle effect
    public func stop() {
        self.birthRate = 0
    }
}
