//
//  protocol GameBackgroundSpriteable + Extension.swift
//  WarJet
//
//  Created by Дмитрий on 01.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.


import SpriteKit
import GameplayKit

protocol GameBackGroundSpriteable {
    static func populate(at point: CGPoint?) -> Self
    static func randomPoint() -> CGPoint
}
extension GameBackGroundSpriteable {
    static func randomPoint() -> CGPoint {
        
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue:Int(screen.size.height + 100), highestValue: Int(screen.size.height + 200))
        
        let y = CGFloat(distribution.nextInt())
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        return CGPoint(x: x, y: y) // генерирование рандомной точки, котороая по "y" распологается от 100 до 200, а по "x" от нуля до ширины экрана
    }
}
