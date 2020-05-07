//
//  Background.swift
//  WarJet
//
//  Created by Дмитрий on 30.04.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

// Создание бэкграунда


class Background: SKSpriteNode {
    
    static func populateBackground(at point:CGPoint) -> Background {
        let background = Background(imageNamed: "background")
    
        background.position = point
        background.zPosition = 0
        return background
        
        
    }

}
