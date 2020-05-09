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
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}
