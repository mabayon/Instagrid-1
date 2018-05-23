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
    enum ViewMovement { case out, backIn }
    let layoutTransition = BlurViewController()
    
    
    @IBOutlet weak var grids: UIView!
    
    @IBOutlet weak var topRectangle: UIButton!
    @IBOutlet weak var bottomRectangle: UIButton!
    @IBOutlet weak var topLeftSquare: UIButton!
    @IBOutlet weak var topRightSquare: UIButton!
    @IBOutlet weak var bottomLeftSquare: UIButton!
    @IBOutlet weak var bottomRightSquare: UIButton!
    
    @IBOutlet weak var topRectangleLayout: UIButton!
    @IBOutlet weak var bottomRectangleLayout: UIButton!
    @IBOutlet weak var squaresLayout: UIButton!
    
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var swipeUpLabel: UILabel!
    @IBOutlet weak var signLeft: UIButton!
    @IBOutlet weak var swipeLeftLabel: UILabel!
    
    
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
        
        var swipeUp = [UISwipeGestureRecognizer]()
        var swipeLeft = [UISwipeGestureRecognizer]()
        
        swipeUp.append(UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:))))
        swipeUp[0].direction = .up
        swipeUp.append(UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:))))
        swipeUp[1].direction = .up
        signUp.addGestureRecognizer(swipeUp[0])
        swipeUpLabel.addGestureRecognizer(swipeUp[1])
        
        swipeLeft.append(UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:))))
        swipeLeft[0].direction = .left
        swipeLeft.append(UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:))))
        swipeLeft[1].direction = .left
        signLeft.addGestureRecognizer(swipeLeft[0])
        swipeLeftLabel.addGestureRecognizer(swipeLeft[1])
        
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
    
    //MARK: choose grid's layout
    @IBAction func chooseLayout(_ sender: UIButton) {
        switch sender.tag {
            /*
             -- grids selectors tags layout --
             
             topRectangleLayout.tag = 0
             bottomRectangleLayout.tag = 1
             squaresLayout.tag = 2
             */
        case 0:
            topRectangle.isHidden = false
            bottomRectangle.isHidden = true
            bottomLeftSquare.isHidden = false
            bottomRightSquare.isHidden = false
            topLeftSquare.isHidden = true
            topRightSquare.isHidden = true
            
            sender.isSelected = true
            bottomRectangleLayout.isSelected = false
            squaresLayout.isSelected = false
            
            layoutTransition.blurUnblur(view: grids)
            
        case 1:
            topRectangle.isHidden = true
            bottomRectangle.isHidden = false
            topLeftSquare.isHidden = false
            topRightSquare.isHidden = false
            bottomLeftSquare.isHidden = true
            bottomRightSquare.isHidden = true
            
            sender.isSelected = true
            topRectangleLayout.isSelected = false
            squaresLayout.isSelected = false
            
            layoutTransition.blurUnblur(view: grids)

            
        case 2:
            topRectangle.isHidden = true
            bottomRectangle.isHidden = true
            topLeftSquare.isHidden = false
            topRightSquare.isHidden = false
            bottomLeftSquare.isHidden = false
            bottomRightSquare.isHidden = false
            
            sender.isSelected = true
            topRectangleLayout.isSelected = false
            bottomRectangleLayout.isSelected = false
            
            layoutTransition.blurUnblur(view: grids)
            
        default:
            break
        }
    }
    
    //MARK: swipe to share
    @objc func swipeGesture(with gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            moveViewVertically(.out)
            shareGrid(with: RenderViewToImage.render(grids, defaultImage: #imageLiteral(resourceName: "Icon-Original")), deviceOrientation: "portrait")
        case .left:
            moveViewHorizontally(.out)
            shareGrid(with: RenderViewToImage.render(grids, defaultImage: #imageLiteral(resourceName: "Icon-Original")), deviceOrientation: "landscape")
        default:
            break
        }
    }

    private func moveViewVertically(_ movement: ViewMovement) {
        switch movement {
        case .out:
            UIView.animate(withDuration: 0.5) {
                self.grids.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            }
        case .backIn:
            UIView.animate(withDuration: 0.5) {
                self.grids.transform = .identity
            }
        }
    }

    private func moveViewHorizontally(_ movement: ViewMovement) {
        switch movement {
        case .out:
            UIView.animate(withDuration: 0.5) {
                self.grids.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            }
        case .backIn:
            UIView.animate(withDuration: 0.5) {
                self.grids.transform = .identity
            }
        }
    }
    
    //MARK: share
    private func shareGrid(with imageToShare: UIImage, deviceOrientation: String) {
        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        switch deviceOrientation {
        case "portrait":
            activityViewController.completionWithItemsHandler = {(UIActivityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if !completed {
                    self.moveViewVertically(.backIn)
                }
                    self.moveViewVertically(.backIn)
            }
        case "landscape":
            activityViewController.completionWithItemsHandler = {(UIActivityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if !completed {
                    self.moveViewHorizontally(.backIn)
                }
                    self.moveViewHorizontally(.backIn)
            }
        default:
            break
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
}

