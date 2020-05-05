//
//  PowerUp.swift
//  WarJet
//
//  Created by Дмитрий on 04.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

// Класс для управления прокачкой (POWERUP)

import SpriteKit
import UIKit

class PowerUp: SKSpriteNode {
    
    let initialSize = CGSize(width: 52, height: 52)
    let textureAtlas = SKTextureAtlas(named: "GreenPowerUp")
    var animationSpriteArray = [SKTexture]()
    
    init() {
        let greenTexture = textureAtlas.textureNamed("Missile_01")
        super.init(texture: greenTexture, color: .clear, size: initialSize)
        self.name = "powerUp"
        self.zPosition = 20
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performRotation() { // Метод для анимаци powerUp
        for i in 1...16 {
            
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: "Missile_\(number)"))
        }
        SKTexture.preload(animationSpriteArray) {
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.2, resize: true, restore: false)
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
        
    }
    
    
    
    
    
    

}