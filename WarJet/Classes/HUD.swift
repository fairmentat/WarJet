//
//  HUD.swift
//  WarJet
//
//  Created by Дмитрий on 07.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit

class HUD: SKNode {
    
    
    let scoreBackground = SKSpriteNode(imageNamed: "scores")
    let scoreLabel = SKLabelNode(text: "1000")
    let menuButton = SKSpriteNode(imageNamed: "menu")
    let life1 = SKSpriteNode(imageNamed: "life")
    let life2 = SKSpriteNode(imageNamed: "life")
    let life3 = SKSpriteNode(imageNamed: "life")
    
    func configureUI(screenSize: CGSize) { // Делаем UI
        
        scoreBackground.position = CGPoint(x: scoreBackground.size.width + 10, y: screenSize.height - scoreBackground.size.height / 2 - 10)
        scoreBackground.anchorPoint = CGPoint(x: 1.0, y: 0.5) // Фон счётчика очков
        scoreBackground.zPosition = 99
        //scoreBackground.xScale = 0.5
        //scoreBackground.setScale(0.8)
        addChild(scoreBackground)
        
        
        scoreLabel.horizontalAlignmentMode = .right // Текст счётчика очков
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: -25, y: 3)
        scoreLabel.zPosition = 100
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 30
        scoreBackground.addChild(scoreLabel)
        
        menuButton.position = CGPoint(x: 10, y: 10) // Кнопка меню
        menuButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        menuButton.zPosition = 100
        menuButton.setScale(0.4)
        menuButton.name = "pause"
        addChild(menuButton)
        
        let lifes = [life1, life2, life3] // Добавляем "Жизни"
        for (index, life) in lifes.enumerated() {
            life.position = CGPoint(x: screenSize.width - CGFloat(index + 1) * (life.size.width + 3), y: 10)
            life.zPosition = 100
            life.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            life.setScale(0.4)
            addChild(life)
            
            
            
            
            
        }
        
        
        
        
    }
    
}
