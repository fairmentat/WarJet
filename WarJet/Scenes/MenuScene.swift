//
//  MenuScene.swift
//  WarJet
//
//  Created by Дмитрий on 06.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

// Класс для создания дополнительной сцены с кнопкой старта (сцена необходима для предзагрузки атласов)

import SpriteKit

class MenuScene: ParrentScene {
    
    override func didMove(to view: SKView) {
        
        if !Assets.shared.isLoaded {
            
            Assets.shared.preloadAssets()
            Assets.shared.isLoaded = true
            
            
        }
        
       // self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        
        setHeader(withName: nil, andBackground: "header1")
        
       // let header = SKSpriteNode(imageNamed: "header1") // Удалили старую кнопку Play и добавили логотип
        //let texture = SKTexture(imageNamed: "Play")
        //let button = SKSpriteNode(texture: texture)
        //header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 170)
        //button.name = "runButton"
        //header.setScale(1.6)
        //self.addChild(header)
        
        
        let titles = ["play", "options", "best"]
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
        if node.name == "play" {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        } else if node.name == "options" {
            
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
            let optionScenes = OptionsScene(size: self.size)
            optionScenes.backScene = self
            //guard let gameScene = sceneManager.gameScene else {return}
           
            optionScenes.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionScenes, transition: transition)
            
            
        } else if node.name == "best" {
            
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
            let bestScene = BestScene(size: self.size)
             bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(bestScene, transition: transition)
            
            
        }
    }
            
            
        }
    
    
    
    
/* Рабочий код, но решено было поместить всё это в массив titles
        
       let button1 = ButtonNode(titled: "play", backgroundName: "button_background") // Добавили кнопку Play
       button1.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
       button1.name = "play"
       button1.label.name = "play"
       addChild(button1)
       
       
       
       
       let button2 = ButtonNode(titled: "options", backgroundName: "button_background") // Добавили кнопку опций
       button2.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
       button2.name = "options"
       button2.label.name = "options"
       addChild(button2)
       
       
       
       
       let button3 = ButtonNode(titled: "best", backgroundName: "button_background") // Добавили кнопку лучший ковбой на диком западе
       button3.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200)
       button3.name = "best"
       button3.label.name = "best"
       addChild(button3)
       */
