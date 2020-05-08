//
//  OptionsScene.swift
//  WarJet
//
//  Created by Дмитрий on 08.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit

class OptionsScene: ParrentScene {
    
    override func didMove(to view: SKView) {
        
        
        
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        
        
        
        
        setHeader(withName: "options", andBackground: "header_background")
        
        
        //let titles = ["restart", "options", "resume"]
        
        
        let music = ButtonNode(titled: nil, backgroundName: "music") // Добавили кнопку Music
        music.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
        music.name = "music"
        music.label.isHidden = true
        addChild(music)
        
        let sound = ButtonNode(titled: nil, backgroundName: "sound") // Добавили кнопку "Sound"
        sound.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
        sound.name = "sound"
        sound.label.isHidden = true
        addChild(sound)
        
        let back = ButtonNode(titled: "back", backgroundName: "button_background") // Добавили кнопку Back
        back.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        back.name = "back"
        back.label.name = "back"
        addChild(back)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        if node.name == "music" {
            print("music")
        }else if node.name == "sound" {
            print("sound")
        }else if node.name == "back" {
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
            guard let backScene = backScene else {return}
            //guard let gameScene = sceneManager.gameScene else {return}
            backScene.scaleMode = .aspectFill
            //gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(backScene, transition: transition)
            
            
        }
        
        
        
    }
    
    
    
    
    
}
