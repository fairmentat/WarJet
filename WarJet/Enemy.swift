//
//  Enemy.swift
//  WarJet
//
//  Created by Дмитрий on 05.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//
// Класс активации вражеского самолёта

import SpriteKit

class Enemy: SKSpriteNode {
    static var textureAtlas: SKTextureAtlas?
    
    static var enemyTexture:SKTexture?
    init(enemyTexture:SKTexture) {
        
        let texture = enemyTexture
        super.init(texture: texture, color: .clear, size: CGSize(width: 529, height: 762))
        self.xScale = 0.15
        self.yScale = 0.15
        self.zPosition = 20
        self.name = "sprite"
    
        
    }
    
    
    func flySpiral() { // Полёт шмеля  (движение по спирали)
        let screenSize = UIScreen.main.bounds
        
        let timeHorizontal: Double  = 3
        let timeVertical: Double  = 5
        let moveLeft = SKAction.moveTo(x: 45, duration: timeHorizontal)
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: screenSize.width - 45, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        let randomNumber = Int(arc4random_uniform(2))
        let asideMovementSequence = randomNumber == EnemyDirection.left.rawValue ? SKAction.sequence([moveLeft, moveRight]): SKAction.sequence([moveRight, moveLeft])
        
        //let asideMovementSequence = SKAction.sequence([moveLeft, moveRight])
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        
        
        let forwardMovement = SKAction.moveTo(y: -105, duration: timeVertical)
        
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovement])
        self.run(groupMovement)
        
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum EnemyDirection: Int {
        
        case left = 0
        case right
        
        
        
        
    }
    
    
    
    

}
