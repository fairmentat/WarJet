//
//  PauseScene.swift
//  WarJet
//
//  Created by Дмитрий on 08.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit


class PauseScene: SKScene {
    override func didMove(to view: SKView) {
           
          
           
           self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
           
           
           
           let header = ButtonNode(titled: "pause", backgroundName: "header_background")
           header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 170)
           //header.setScale(1.6)
           self.addChild(header)
           
           
           let titles = ["restart", "options", "resume"]
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
               let transition = SKTransition.crossFade(withDuration: 1.0)
               let gameScene = GameScene(size: self.size)
               gameScene.scaleMode = .aspectFill
               self.scene!.view?.presentScene(gameScene, transition: transition)
           }
       
       
       
       }

}
