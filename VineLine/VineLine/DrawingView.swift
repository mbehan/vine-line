//
//  DrawingView.swift
//  VineLine
//
//  Created by Michael Behan on 17/03/2019.
//  Copyright © 2019 Michael Behan. All rights reserved.
//

import UIKit

class DrawingView: UIView {

    var lines = [UIBezierPath]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup(){
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panHandler(panRecognizer:)))
        self.addGestureRecognizer(panRecognizer)
        
    }

    @objc func panHandler(panRecognizer: UIGestureRecognizer) {

        switch panRecognizer.state {
        case .began:
            let path = UIBezierPath()
            path.move(to: panRecognizer.location(in: self))
            lines.append(path)
        case .changed, .ended, .cancelled:
            lines.last?.addLine(to: panRecognizer.location(in: self))
        default: break
        }

        self.setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        for line in lines {
            line.stroke()
        }
    }

}
