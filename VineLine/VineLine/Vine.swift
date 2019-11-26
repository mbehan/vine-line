//
//  Vine.swift
//  VineLine
//
//  Created by Michael Behan on 26/11/2019.
//  Copyright © 2019 Michael Behan. All rights reserved.
//

import UIKit

class Vine: UIBezierPath {

    var leafSize: Double = 10.0
    var maxBranchLength: Double = 100.0
    var minBranchSeperation = 50.0
    var color = UIColor.green

    weak var delegate: BranchingDelegate?

    private var hasNoBranches = true
    private var firstPoint: CGPoint!
    private var lastBranchPosition: CGPoint!

    override func move(to point: CGPoint) {
        super.move(to: point)

        firstPoint = point
    }

    override func addLine(to point: CGPoint) {
        super.addLine(to: point)

        var distanceFromPrevious = 0.0

        if(hasNoBranches) {
            distanceFromPrevious = hypot(Double(point.x - firstPoint.x), Double(point.y - firstPoint.y));
        } else {
            distanceFromPrevious = hypot(Double(point.x - lastBranchPosition.x), Double(point.y - lastBranchPosition.y))
        }

        if(distanceFromPrevious > minBranchSeperation) {
            let newBranch = Branch(start: point, maxLength: CGFloat(maxBranchLength), leafSize: CGFloat(leafSize), color: color)
            newBranch.lineWidth = self.lineWidth / 2.0

            hasNoBranches = false
            delegate?.vineDidCreate(branch: newBranch)
            lastBranchPosition = point;
        }
    }
}
