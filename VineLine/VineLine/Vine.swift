//
//  Vine.swift
//  VineLine
//
//  Created by Michael Behan on 26/11/2019.
//  Copyright © 2019 Michael Behan. All rights reserved.
//

import UIKit

class Vine: UIBezierPath {

    var leafSize: Double
    var maxBranchLength: Double
    var minBranchSeperation: Double
    weak var delegate: VineDelegate?
    var lines: [Branch]
    var color: UIColor

    private var firstPoint: CGPoint!
    private var lastBranchPosition: CGPoint!


    override init(){

        color = .green
        leafSize = 10.0
        maxBranchLength = 10.0
        minBranchSeperation = 10.0
        lines = [Branch]()

        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func move(to point: CGPoint) {
        super.move(to: point)

        firstPoint = point
    }

    override func addLine(to point: CGPoint) {
        super.addLine(to: point)

        var distanceFromPrevious = 0.0

        if(lines.count == 0) {
            distanceFromPrevious = hypot(Double(point.x - firstPoint.x), Double(point.y - firstPoint.y));
        } else {
            distanceFromPrevious = hypot(Double(point.x - lastBranchPosition.x), Double(point.y - lastBranchPosition.y))
        }

        if(distanceFromPrevious > minBranchSeperation) {
            let newBranch = Branch(start: point, maxLength: CGFloat(maxBranchLength), leafSize: CGFloat(leafSize), color: color)
            newBranch.lineWidth = self.lineWidth / 2.0

            lines.append(newBranch)
            delegate?.vineDidCreate(branch: newBranch)
            lastBranchPosition = point;
        }
    }

}
