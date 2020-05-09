//
//  GameOverScene.swift
//  WarJet
//
//  Created by Дмитрий on 09.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit

class GameOverScene: ParrentScene {
    
    
        
        override func didMove(to view: SKView) {
            
            setHeader(withName: "game over", andBackground: "header_background")
            
            
            let titles = ["restart", "options", "best"]
            for (index, title) in titles.enumerated() {
                
                let button = ButtonNode(titled: title, backgroundName: "button_background") // Добавили кнопку Play
                button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
                button.name = title
                button.label.name = title
                addChild(button)
                
            }
            
            
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let location = touches.first!.location(in: self)
            let node = self.atPoint(location)
            if node.name == "restart" {
                sceneManager.gameScene = nil
                let transition = SKTransition.flipHorizontal(withDuration: 1.0)
                let gameScene = GameScene(size: self.size)
                gameScene.scaleMode = .aspectFill
                self.scene!.view?.presentScene(gameScene, transition: transition)
            }
            else if node.name == "options" {
                
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
                let optionsScene = OptionsScene(size: self.size)
                 optionsScene.backScene = self
                optionsScene.scaleMode = .aspectFill
                self.scene!.view?.presentScene(optionsScene, transition: transition)
                
                
            }
            else if node.name == "best" {
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
                let bestScene = BestScene(size: self.size)
                bestScene.backScene = self
                bestScene.scaleMode = .aspectFill
                self.scene!.view?.presentScene(bestScene, transition: transition)
                
                
            }
            
            
            
        }
        
    

}
