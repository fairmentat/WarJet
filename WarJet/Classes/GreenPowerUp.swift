//
//  GreenPowerUp.swift
//  WarJet
//
//  Created by Дмитрий on 06.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

//import UIKit
import SpriteKit

class GreenPowerUp: PowerUp { // Подкласс для зелёных паверапов
    init(){
        let textureAtlas = Assets.shared.greenPowerUpAtlas  //SKTextureAtlas(named: "GreenPowerUp")
          
          super.init(textureAtlas: textureAtlas)
          
          
      }
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
    
    
    
}
