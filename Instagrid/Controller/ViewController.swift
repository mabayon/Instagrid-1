//
//  ViewController.swift
//  Instagrid
//
//  Created by Morgan on 16/05/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var buttonTapped = UIButton()
    
    @IBOutlet weak var topRectangle: UIButton!
    @IBOutlet weak var bottomRectangle: UIButton!
    @IBOutlet weak var topLeftSquare: UIButton!
    @IBOutlet weak var topRightSquare: UIButton!
    @IBOutlet weak var bottomLeftSquare: UIButton!
    @IBOutlet weak var bottomRightSquare: UIButton!
    
    @IBOutlet weak var topRectangleLayout: UIButton!
    @IBOutlet weak var bottomRectangleLayout: UIButton!
    @IBOutlet weak var squaresLayout: UIButton!
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        buttonTapped.setImage(selectedImage, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //MARK: pick photos
    @IBAction func tapToPickPhoto(_ sender: UIButton) {
        switch sender.tag {
            /*
             -- grids objects tag's layout --
             topLeftSquare.tag = 1OO
             topRightSquare.tag = 101
             bottomLeftSquare.tag = 102
             bottomRightSquare.tag = 1O3
             topRectangle.tag = 110
             bottomRectangle.tag = 111
             */
        case 100:
            pickPhotoFromLibrary(for: sender)
        case 101:
            pickPhotoFromLibrary(for: sender)
        case 102:
            pickPhotoFromLibrary(for: sender)
        case 103:
            pickPhotoFromLibrary(for: sender)
        case 110:
            pickPhotoFromLibrary(for: sender)
        case 111:
            pickPhotoFromLibrary(for: sender)
        default:
            break
            
        }
    }
    
    
    private func pickPhotoFromLibrary(for sender: UIButton) {
        buttonTapped = sender
        
        let imagePickerController = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
            imagePickerController.sourceType = .photoLibrary
        } else {
            return
        }
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

        
}

