//
//  DrawingView.swift
//  VineLine
//
//  Created by Michael Behan on 17/03/2019.
//  Copyright © 2019 Michael Behan. All rights reserved.
//

import UIKit

class MultiTouchDrawingView: UIView {
    
    typealias Stroke = (path: UIBezierPath, color: UIColor)

    private let lineWidth = CGFloat(5.0)
    private var activeStrokes = [UITouch: Stroke]()
    private var strokes = [Stroke]()
    
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
            let newStroke = (path: UIBezierPath(), color: UIColor.random)
            newStroke.path.lineCapStyle = .round
            newStroke.path.lineWidth = lineWidth
            newStroke.path.move(to: location)
            newStroke.path.addLine(to: location)
            activeStrokes[touch] = newStroke
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            activeStrokes[touch]!.path.addLine(to: touch.location(in: self))
        }
        self.setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let line = activeStrokes.removeValue(forKey: touch)!
            line.path.move(to: touch.location(in: self))
            strokes.append(line)
        }
        self.setNeedsDisplay()
    }
    
    // MARK:- Drawing
    
    override func draw(_ rect: CGRect) {
        for line in strokes {
            line.color.setStroke()
            line.path.stroke()
        }
        
        for line in activeStrokes.values {
            line.color.setStroke()
            line.path.stroke()
        }
    }
}
