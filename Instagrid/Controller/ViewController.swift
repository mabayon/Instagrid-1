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
    enum ViewDirection { case out, backIn }
    let layoutTransition = BlurView()
    
    
    @IBOutlet weak var gridsView: UIView!
    
    @IBOutlet weak var topRectangleButton: UIButton!
    @IBOutlet weak var bottomRectangleButton: UIButton!
    @IBOutlet weak var topLeftSquareButton: UIButton!
    @IBOutlet weak var topRightSquareButton: UIButton!
    @IBOutlet weak var bottomLeftSquareButton: UIButton!
    @IBOutlet weak var bottomRightSquareButton: UIButton!
    
    @IBOutlet weak var topRectangleLayoutButton: UIButton!
    @IBOutlet weak var bottomRectangleLayoutButton: UIButton!
    @IBOutlet weak var squaresLayoutButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var swipeUpLabelLabel: UILabel!
    @IBOutlet weak var signLeftButton: UIButton!
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
        
        self.createSwipeGesture()
    }
    
    
    //MARK: pick photos
    @IBAction func tapToPickPhoto(_ sender: UIButton) {
        switch sender.tag {
            /*
             -- gridsView objects tag's layout --
             topLeftSquareButton.tag = 1OO
             topRightSquareButton.tag = 101
             bottomLeftSquareButton.tag = 102
             bottomRightSquareButton.tag = 1O3
             topRectangleButton.tag = 110
             bottomRectangleButton.tag = 111
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
             -- gridsView selectors tags layout --
             
             topRectangleLayoutButton.tag = 0
             bottomRectangleLayout.tag = 1
             squaresLayout.tag = 2
             */
        case 0:
            presentTopRectangleLayout(sender: sender)
        case 1:
            presentBottomRectangleLayout(sender: sender)
        case 2:
            presentFourSquaresLayout(sender: sender)
        default:
            break
        }
        
        layoutTransition.blurUnblur(view: gridsView)
    }
    
    func presentTopRectangleLayout(sender: UIButton) {
        topRectangleButton.isHidden = false
        bottomRectangleButton.isHidden = true
        bottomLeftSquareButton.isHidden = false
        bottomRightSquareButton.isHidden = false
        topLeftSquareButton.isHidden = true
        topRightSquareButton.isHidden = true
        
        sender.isSelected = true
        bottomRectangleLayoutButton.isSelected = false
        squaresLayoutButton.isSelected = false
    }
    
    func presentBottomRectangleLayout(sender: UIButton) {
        topRectangleButton.isHidden = true
        bottomRectangleButton.isHidden = false
        topLeftSquareButton.isHidden = false
        topRightSquareButton.isHidden = false
        bottomLeftSquareButton.isHidden = true
        bottomRightSquareButton.isHidden = true
        
        sender.isSelected = true
        topRectangleLayoutButton.isSelected = false
        squaresLayoutButton.isSelected = false
    }
    
    func presentFourSquaresLayout(sender: UIButton) {
        topRectangleButton.isHidden = true
        bottomRectangleButton.isHidden = true
        topLeftSquareButton.isHidden = false
        topRightSquareButton.isHidden = false
        bottomLeftSquareButton.isHidden = false
        bottomRightSquareButton.isHidden = false
        
        sender.isSelected = true
        topRectangleLayoutButton.isSelected = false
        bottomRectangleLayoutButton.isSelected = false
    }
    
    //MARK: create swipe gesture
    private func createSwipeGesture() {
        var swipeUp = [UISwipeGestureRecognizer]()
        var swipeLeft = [UISwipeGestureRecognizer]()
        
        swipeUp.append(UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:))))
        swipeUp[0].direction = .up
        swipeUp.append(UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:))))
        swipeUp[1].direction = .up
        signUpButton.addGestureRecognizer(swipeUp[0])
        swipeUpLabelLabel.addGestureRecognizer(swipeUp[1])
        
        swipeLeft.append(UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:))))
        swipeLeft[0].direction = .left
        swipeLeft.append(UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:))))
        swipeLeft[1].direction = .left
        signLeftButton.addGestureRecognizer(swipeLeft[0])
        swipeLeftLabel.addGestureRecognizer(swipeLeft[1])
    }
    
    //MARK: swipe to share
    @objc func swipeGesture(with gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            moveViewVertically(.out)
            shareGrid(with: RenderViewToImage.render(gridsView, defaultImage: #imageLiteral(resourceName: "Icon-Original")), deviceOrientation: "portrait")
        case .left:
            moveViewHorizontally(.out)
            shareGrid(with: RenderViewToImage.render(gridsView, defaultImage: #imageLiteral(resourceName: "Icon-Original")), deviceOrientation: "landscape")
        default:
            break
        }
    }

    private func moveViewVertically(_ movement: ViewDirection) {
        switch movement {
        case .out:
            UIView.animate(withDuration: 0.5) {
                self.gridsView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            }
        case .backIn:
            UIView.animate(withDuration: 0.5) {
                self.gridsView.transform = .identity
            }
        }
    }

    private func moveViewHorizontally(_ movement: ViewDirection) {
        switch movement {
        case .out:
            UIView.animate(withDuration: 0.5) {
                self.gridsView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            }
        case .backIn:
            UIView.animate(withDuration: 0.5) {
                self.gridsView.transform = .identity
            }
        }
    }
    
    //MARK: share
    private func shareGrid(with imageToShare: UIImage, deviceOrientation: String) {
        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        switch deviceOrientation {
        case "portrait":
            activityViewController.completionWithItemsHandler = {(UIActivityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                    self.moveViewVertically(.backIn)
            }
        case "landscape":
            activityViewController.completionWithItemsHandler = {(UIActivityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                    self.moveViewHorizontally(.backIn)
            }
        default:
            break
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
}

