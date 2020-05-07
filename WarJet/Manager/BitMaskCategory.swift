//
//  BitMaskCategory.swift
//  WarJet
//
//  Created by Дмитрий on 06.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//


// Создание битовых масок (для взаимодействия объектов)

//import Foundation
import SpriteKit

//enum BitMaskCategory {
//
//
//    case player
//    case enemy
//    case powerUp
//    case shot
//
//}

extension SKPhysicsBody {
    var category: BitMaskCategory {
        
        get {
            return BitMaskCategory(rawValue: self.categoryBitMask)
        }
        
        set {
            
            self.categoryBitMask = newValue.rawValue
            
        }
    }
    
    
    
    
    
    
}


struct BitMaskCategory: OptionSet { // Побитовое смещение
    
    let rawValue: UInt32
    //init(rawValue: UInt32) {self.rawValue = rawValue}
    
    static let none = BitMaskCategory(rawValue: 0 << 0)      // 000000000000000..0
    static let player = BitMaskCategory(rawValue: 1 << 0)    // 00000000000000..01
    static let enemy = BitMaskCategory(rawValue: 1 << 1)     // 00000000000000..10
    static let powerUp = BitMaskCategory(rawValue: 1 << 2)   // 0000000000000..100
    static let shot = BitMaskCategory(rawValue: 1 << 3)      // 000000000000..1000
    
    static let all = BitMaskCategory(rawValue: UInt32.max) // Весь набор
    
}
