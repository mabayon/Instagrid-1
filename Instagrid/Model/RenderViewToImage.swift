//
//  RenderViewToImage.swift
//  Instagrid
//
//  Created by Morgan on 16/05/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class RenderViewToImage: UIImage {
    
    static func render(_ view: UIView, defaultImage: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0)
        defer { UIGraphicsEndImageContext() }
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext() ?? defaultImage
    }
    
}

