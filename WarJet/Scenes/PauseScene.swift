//
//  PauseScene.swift
//  WarJet
//
//  Created by Дмитрий on 08.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit


class PauseScene: ParrentScene {
    
    //let sceneManager = SceneManager.shared
    
    override func didMove(to view: SKView) {
        
        
        
       // self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        
        
        
//        let header = ButtonNode(titled: "pause", backgroundName: "header_background")
//        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 170)
//        self.addChild(header)
        
        setHeader(withName: "pause", andBackground: "header_background")
        
        
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
            sceneManager.gameScene = nil
            let transition = SKTransition.flipHorizontal(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
        else if node.name == "options" {
            
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
            let optionsScene = OptionsScene(size: self.size)            //guard let gameScene = sceneManager.gameScene else {return}
            //let gameScene = sceneManager.gameScene
             optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
            
            
        }
        else if node.name == "resume" {
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
            //optionsScene.backScene = self
            guard let gameScene = sceneManager.gameScene else {return}
            //let gameScene = sceneManager.gameScene
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
            
            
        }
        
        
        
    }
    
}
