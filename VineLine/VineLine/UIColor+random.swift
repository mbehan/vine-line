//
//  UIColor+random.swift
//  VineLine
//
//  Created by Michael Behan on 17/04/2019.
//  Copyright © 2019 Michael Behan. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0)
    }
}
