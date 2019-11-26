//
//  DrawingView.swift
//  VineLine
//
//  Created by Michael Behan on 17/03/2019.
//  Copyright © 2019 Michael Behan. All rights reserved.
//

import UIKit

class VineLineDrawingView: UIView, VineDelegate {
    func vineDidCreate(branch: Branch) {

        let branchShape = CAShapeLayer()
        branchShape.path = branch.cgPath
        branchShape.fillColor = UIColor.clear.cgColor
        branchShape.strokeColor = branch.color.cgColor
        branchShape.lineWidth = branch.lineWidth

        layer.addSublayer(branchShape)

        let branchGrowAnimation = CABasicAnimation(keyPath: "strokeEnd")
        branchGrowAnimation.duration = 1.0
        branchGrowAnimation.fromValue = 0.0
        branchGrowAnimation.toValue = 1.0
        branchShape.add(branchGrowAnimation, forKey: "strokeEnd")

    }


    private let lineWidth = CGFloat(5.0)
    private var activeStrokes = [UITouch: Vine]()
    private var strokes = [Vine]()

    var leafSize = 10.0
    var branchSeperation = 100.0
    var vineWidth = 5.0
    var branchLength = 50.0
    
    // MARK:- Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup(){
        isMultipleTouchEnabled = true
    }
    
    // MARK:- Touch handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isMultipleTouchEnabled = true
        for touch in touches {
            let location = touch.location(in: self)
            let newVine = Vine()
            newVine.lineCapStyle = .round
            newVine.lineWidth = lineWidth
            newVine.move(to: location)
            newVine.addLine(to: location)
            newVine.delegate = self
            newVine.lineWidth = CGFloat(vineWidth)
            newVine.minBranchSeperation = branchSeperation
            newVine.maxBranchLength = branchLength
            newVine.leafSize = leafSize
            newVine.color = UIColor.random
            activeStrokes[touch] = newVine
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            activeStrokes[touch]!.addLine(to: touch.location(in: self))
        }
        self.setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let line = activeStrokes.removeValue(forKey: touch)!
            line.move(to: touch.location(in: self))
            strokes.append(line)
        }
        self.setNeedsDisplay()
    }
    
    // MARK:- Drawing
    
    override func draw(_ rect: CGRect) {
        for line in strokes {
            line.color.setStroke()
            line.stroke()
        }
        
        for line in activeStrokes.values {
            line.color.setStroke()
            line.stroke()
        }
    }
}
