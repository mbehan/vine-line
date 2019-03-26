//
//  DrawingView.swift
//  VineLine
//
//  Created by Michael Behan on 17/03/2019.
//  Copyright © 2019 Michael Behan. All rights reserved.
//

import UIKit

class DrawingView: UIView {

    private let lineWidth = CGFloat(1.0)
    private var activeLines = [UITouch: UIBezierPath]()
    private var lines = [UIBezierPath]()
    
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
            let newStroke = UIBezierPath()
            newStroke.lineCapStyle = .round
            newStroke.lineWidth = lineWidth
            newStroke.move(to: location)
            newStroke.addLine(to: location)
            activeLines[touch] = newStroke
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            activeLines[touch]!.addLine(to: touch.location(in: self))
        }
        self.setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let line = activeLines.removeValue(forKey: touch)!
            line.move(to: touch.location(in: self))
            lines.append(line)
        }
        self.setNeedsDisplay()
    }
    
    // MARK:- Drawing
    
    override func draw(_ rect: CGRect) {
        for line in activeLines.values {
            line.stroke()
        }

        for line in lines {
            line.stroke()
        }
    }
}
