//
//  BestScene.swift
//  WarJet
//
//  Created by Дмитрий on 09.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//





// Делаем сцену для BEST!
import SpriteKit

class BestScene: ParrentScene {
    
    
    var places = [10, 100, 10000] // Массив для добавления результатов
    
    
    override func didMove(to view: SKView) {
        
        
        
        
        
        
        
        
        setHeader(withName: "best", andBackground: "header_background")
        
        
        //let titles = ["restart", "options", "resume"]
        
        // Кнопка на сцене
        let titles = ["back"]
        for (index, title) in titles.enumerated() {
            
            let button = ButtonNode(titled: title, backgroundName: "button_background") // Добавили кнопку Play
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200 + CGFloat(100 * index))
            button.name = title
            button.label.name = title
            addChild(button)
            
        }
        
        
        
        let topPlaces = places.sorted { $0 > $1 }.prefix(3) // Сортировка массив и ограничение до 3х показателей
        
        for (index, value) in topPlaces.enumerated() { // Добавялем показатели
            let l = SKLabelNode(text: value.description)
            l.fontColor = UIColor(red: 219 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1.0)
            l.fontName = "AmericanTypewriter-Bold"
            l.fontSize = 30
            l.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index * 60))
            addChild(l)
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        if node.name == "back" {
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
            guard let backScene = backScene else {return}
            //guard let gameScene = sceneManager.gameScene else {return}
            backScene.scaleMode = .aspectFill
            //gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(backScene, transition: transition)
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
}
