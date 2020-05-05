//
//  PowerUp.swift
//  WarJet
//
//  Created by Дмитрий on 04.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit
import UIKit

class PowerUp: SKSpriteNode {
    
    let initialSize = CGSize(width: 52, height: 52)
    let textureAtlas = SKTextureAtlas(named: "GreenPowerUp")
    var animationSpriteArray = [SKTexture]()
    
    init() {
        let greenTexture = textureAtlas.textureNamed("Missile 01")
        super.init(texture: <#T##SKTexture?#>, color: .clear, size: initialSize)
        self.name = "powerUp"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performRotation() {
        for i in 1...16 {
            
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: "Missile \(number)"))
        }
        SKTexture.preload(animationSpriteArray) {
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.5, resize: true, restore: false)
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
        
    }
    
    
    
    
    
    

}
