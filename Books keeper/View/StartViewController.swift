//
//  ViewController.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 28.01.2022.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet var bookKepperView: UIImageView!
    @IBOutlet var bookView: UIImageView!
    @IBOutlet var spinnerView: UIImageView!
    @IBOutlet var startButton: UIButton!
    
    private var isFirstOpen: Bool? = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startConfigureUI()
        
        if let isFirstOpen = UserDefaults.standard.value(forKey: "isFirstOpen") {
            self.isFirstOpen = isFirstOpen as? Bool
        }
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rotate(spinnerView)
    }
    @IBAction func startButtonPressed() {
        isFirstOpen = false
        UserDefaults.standard.set(isFirstOpen, forKey: "isFirstOpen")
        performSegue(withIdentifier: SegueIdentifier.bookList.rawValue, sender: self)
    }
}

extension StartViewController: CAAnimationDelegate {
    
    func rotate(_ view: UIImageView) {
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        rotation.duration = 0.6
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi * 2
        rotation.fillMode = .both
        rotation.isRemovedOnCompletion = false
        rotation.repeatDuration = CFTimeInterval.random(in: 2...5)
        rotation.delegate = self
        
        view.layer.add(rotation, forKey: "rotate")
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        reversOpacity(spinnerView)
        switch isFirstOpen {
            
        case true:
            appearUI()
            
        case false:
            performSegue(withIdentifier: SegueIdentifier.bookList.rawValue, sender: nil)
            
        default: break
        }
    }
    
    func reversOpacity(_ view: UIView) {
        
        let reversOpacity = CABasicAnimation(keyPath: "opacity")
        
        reversOpacity.fromValue = 1
        reversOpacity.toValue = 0
        reversOpacity.duration = 1
        reversOpacity.fillMode = .both
        reversOpacity.isRemovedOnCompletion = false
    
        view.layer.add(reversOpacity, forKey: "reversOpacity")
           
    }
    
    func startConfigureUI() {
        startButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        startButton.layer.shadowOpacity = 0.5
        startButton.layer.shadowRadius = 5
        startButton.layer.cornerRadius = 10
        
        bookKepperView.isHidden = true
        bookKepperView.alpha = 0
        bookView.isHidden = true
        bookView.alpha = 0
        startButton.isHidden = true
        startButton.alpha = 0
    }
    
    func appearUI() {
        
        bookKepperView.isHidden = false
        bookView.isHidden = false
        startButton.isHidden = false
        UIView.animate(withDuration: 2,
                       delay: 1,
                       options: []) {
            
            self.bookKepperView.alpha = 1
        }
        
        UIView.animate(withDuration: 2,
                       delay: 2,
                       options: []) {
            self.bookView.alpha = 2
        }
        
        UIView.animate(withDuration: 2,
                       delay: 3,
                       options: []) {
            self.startButton.alpha = 1
        }
        
    }
}

