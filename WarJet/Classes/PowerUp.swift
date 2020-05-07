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

class PowerUp: SKSpriteNode { // Суперкласс для задания методов и свойств
    
    fileprivate let initialSize = CGSize(width: 52, height: 52)
    fileprivate let textureAtlas: SKTextureAtlas!
    fileprivate var textureNameBeingWith = ""
    fileprivate var animationSpriteArray = [SKTexture]()
    
    init(textureAtlas: SKTextureAtlas) {
        //let greenTexture = textureAtlas.textureNamed("Missile_01")
        self.textureAtlas = textureAtlas
        let textureName = textureAtlas.textureNames.sorted()[0]
        
        let texture = textureAtlas.textureNamed(textureName)
        textureNameBeingWith = String(textureName.dropLast(6))
        
        super.init(texture: texture, color: .clear, size: initialSize)
        self.setScale(0.7)
        self.name = "sprite"
        self.zPosition = 20
        // Делаем объект физическим
        self.physicsBody = SKPhysicsBody(texture:  texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.powerUp.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.player.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue
        
        
        
        
    }
    
    
    func startMovement() {
        performRotation()
        
        let moveForward = SKAction.moveTo(y: -100, duration: 5)
        self.run(moveForward)
        
        
        
        
    }
    
    
    
    
    fileprivate func performRotation() { // Метод для анимаци powerUp
        for i in 1...16 {
            
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: textureNameBeingWith + number.description))
        }
        SKTexture.preload(animationSpriteArray) {
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.2, resize: true, restore: false)
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    

}
