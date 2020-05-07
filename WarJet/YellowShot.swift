//
//  YellowShot.swift
//  WarJet
//
//  Created by Дмитрий on 06.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit

class YellowShot: Shot {
    
    init() {
        
        let textureAtlas = Assets.shared.flameAtlas //SKTextureAtlas(named: "Flame")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
