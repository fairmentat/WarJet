//
//  ParrentScene.swift
//  WarJet
//
//  Created by Дмитрий on 08.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit

class ParrentScene: SKScene {
    
    
    let sceneManager = SceneManager.shared
    
    var backScene: SKScene?
    
    func setHeader(withName name: String?, andBackground backgroundName: String) {
        
        let header = ButtonNode(titled: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 180)
        header.setScale(1.5)
        self.addChild(header)
        
        
        
    }
    
    
    
    
    

}
