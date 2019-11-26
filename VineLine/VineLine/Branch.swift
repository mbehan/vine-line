//
//  Branch.swift
//  VineLine
//
//  Created by Michael Behan on 26/03/2019.
//  Copyright © 2019 Michael Behan. All rights reserved.
//

import UIKit

extension CGPoint {
    static func randomPoint(between point1: CGPoint, and point2: CGPoint) -> CGPoint {
        return CGPoint(x: Double.random(in: Double(point1.x) ... Double(point2.x)),
                       y: Double.random(in: Double(point1.y) ... Double(point2.y)))
    }
}

class Branch: UIBezierPath {
    
    init(start: CGPoint, maxLength: CGFloat, leafSize: CGFloat) {
        super.init()
        
        move(to: start)
        
        let end = CGPoint.randomPoint(between: start, and: CGPoint(x: start.x + maxLength, y: start.y + maxLength))
        let control1 = CGPoint.randomPoint(between: start, and: end)
        let control2 = CGPoint.randomPoint(between: start, and: end)
        
        addCurve(to: end, controlPoint1: control1, controlPoint2: control2)
        
        let leaf = UIBezierPath(ovalIn: CGRect(x: end.x - leafSize / 2.0, y: end.y - leafSize / 2.0, width: leafSize, height: leafSize))
        
        append(leaf)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol VineDelegate: class {
    func vineDidCreate(branch: Branch)
}
