//
//  BlurViewController.swift
//  Instagrid
//
//  Created by Morgan on 20/05/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class BlurViewController: UIViewController {
    
    func blurUnblur(view: UIView) {
        blur(view: view)
        unBlur(view: view)
    }
    
    private let blurOverlay = UIVisualEffectView()
    
    private func blur(view: UIView) {
        self.blurOverlay.frame = view.bounds
        view.addSubview(self.blurOverlay)
        UIView.animate(withDuration: 0.3) {
            self.blurOverlay.effect = UIBlurEffect(style: .dark)
        }
    }
    
    private func unBlur(view: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            self.blurOverlay.effect = UIBlurEffect()
        }) { (finished: Bool) in
            self.blurOverlay.removeFromSuperview()
        }
    }
    
}
