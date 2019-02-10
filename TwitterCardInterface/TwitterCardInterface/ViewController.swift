//
//  ViewController.swift
//  TwitterCardInterface
//
//  Created by Osama Naeem on 08/02/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var card = CustomCardView()
    
    var bottomAnchorConstraint: NSLayoutConstraint?
  
    
    var testFlag:Bool = false //Just for testing purposes
    let cardHeight = UIScreen.main.bounds.height * 3/4
    var startingConstant : CGFloat = 0
 
    let backBar : UIView = {
        let bar = UIView()
        bar.backgroundColor = .lightGray
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
 
    func setupView() {
        view.addSubview(card)
        view.addSubview(backBar)
        view.sendSubviewToBack(backBar)
       
        view.backgroundColor = .white
        title = "Twitter Card"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Activate", style: .done, target: self, action: #selector(handleActiveCard))

        layoutView()
        setupGestureRecogizer()
    }
    
    
    func setupGestureRecogizer() {
        card.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(sender:))))
    }

    func layoutView() {
        
        bottomAnchorConstraint = card.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: cardHeight)
        bottomAnchorConstraint?.isActive                                    = true
        card.leftAnchor.constraint(equalTo: view.leftAnchor).isActive       = true
        card.rightAnchor.constraint(equalTo: view.rightAnchor).isActive     = true
        card.heightAnchor.constraint(equalToConstant: cardHeight) .isActive = true
       
        backBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backBar.topAnchor.constraint(equalTo: card.bottomAnchor).isActive = true
        
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
            
        case .began:
            startingConstant = (bottomAnchorConstraint?.constant)!
        case .changed:
            
         
                let translationY = sender.translation(in: self.card).y
                self.bottomAnchorConstraint?.constant = startingConstant + translationY
            
            
           
        case .ended:
            if (Int((self.bottomAnchorConstraint?.constant)!)) < 0 {
                card.animateCardFlow(duration: 0.3, constraint: bottomAnchorConstraint!, constant: 0, initialSpringVelocity: 0.6, usingSpringWithDamping: 0.9) { [unowned self] in
                    self.view.layoutIfNeeded()
                }
            } else if sender.velocity(in: self.card).y > 0 {
                
                //Card is moving down
                if (sender.velocity(in: self.card).y < 300 && Int((self.bottomAnchorConstraint?.constant)!) < 180)
                {
                    card.animateCardFlow(duration: 0.3, constraint: bottomAnchorConstraint!, constant: 0, initialSpringVelocity: 3, usingSpringWithDamping: 0.9) { [unowned self] in
                        self.view.layoutIfNeeded()
                    }
                } else {
                    card.animateCardFlow(duration: 0.5, constraint: bottomAnchorConstraint!, constant: cardHeight, initialSpringVelocity: 0.6, usingSpringWithDamping: 0.9) { [unowned self] in
                        self.view.layoutIfNeeded()
                        self.testFlag.toggle()
                    }
                }
            }else {
                
                //Card is moving up
                card.animateCardFlow(duration: 0.3, constraint: bottomAnchorConstraint!, constant: 0, initialSpringVelocity: 0.6, usingSpringWithDamping: 0.9) { [unowned self] in
                    self.view.layoutIfNeeded()
                }
                
            }
        default:
            break
        }

    }
    

    @objc func handleActiveCard() {
        testFlag.toggle()
         UIView.animate(withDuration: 0.4, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.6, options: .curveEaseInOut, animations: {
            self.testFlag ? ( self.bottomAnchorConstraint?.constant = 0.0 ) : (self.bottomAnchorConstraint?.constant = self.cardHeight)
            self.view.layoutIfNeeded()
        }, completion: nil)
 
    }
}

