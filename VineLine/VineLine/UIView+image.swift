//
//  UIView+image.swift
//  VineLine
//
//  Created by Michael Behan on 08/05/2019.
//  Copyright © 2019 Michael Behan. All rights reserved.
//

import UIKit

extension UIView {
    var imageRepresentation: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        defer { UIGraphicsEndImageContext() }
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
