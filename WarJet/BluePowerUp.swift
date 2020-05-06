//
//  BluePowerUp.swift
//  WarJet
//
//  Created by Дмитрий on 06.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

//import UIKit
import SpriteKit

class BluePowerUp: PowerUp { // Подкласс для зелёных паверапов
    init(){
        let textureAtlas = SKTextureAtlas(named: "BluePowerUp")
        
        super.init(textureAtlas: textureAtlas)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
