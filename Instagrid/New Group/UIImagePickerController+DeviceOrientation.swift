//
//  UIImagePickerController+DeviceOrientation.swift
//  Instagrid
//
//  Created by Morgan on 16/05/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
