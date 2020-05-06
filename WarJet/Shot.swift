//
//  Shot.swift
//  WarJet
//
//  Created by Дмитрий on 06.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit
import UIKit

class Shot: SKSpriteNode {
    
   
    
    let screenSize = UIScreen.main.bounds


    fileprivate let initialSize = CGSize(width: 46, height: 157)
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
        self.setScale(0.3)
        self.name = "shotSprite"
        self.zPosition = 30
        
    }
    
    
    func startMovement() {
        performRotation()
        
        let moveForward = SKAction.moveTo(y: screenSize.height + 100, duration: 2)
        self.run(moveForward)
        
        
        
        
    }
    
    
    
    
    fileprivate func performRotation() { // Метод для анимаци powerUp
        for i in 1...32 {
            
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
