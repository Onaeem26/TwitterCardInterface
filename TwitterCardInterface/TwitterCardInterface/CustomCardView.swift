//
//  customCardView.swift
//  TwitterCardInterface
//
//  Created by Osama Naeem on 08/02/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import UIKit

class CustomCardView : UIView {
    
    let topBar : UIView = {
        let bar = UIView()
        bar.backgroundColor = .black
        bar.layer.cornerRadius = 4
        bar.clipsToBounds = true
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCard()
    }
    
    private func setupCard() {
        
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(topBar)
        
        topBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 8).isActive = true
        topBar.widthAnchor.constraint(equalToConstant: 50).isActive = true
        topBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        
 
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedCorners(corners: [.topLeft, .topRight], radius: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIView {
    
    func roundedCorners(corners : UIRectCorner, radius : CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func animateCardFlow(duration: TimeInterval, constraint: NSLayoutConstraint, constant: CGFloat, initialSpringVelocity: CGFloat, usingSpringWithDamping: CGFloat, completion : @escaping () -> ()) {
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity, options: .curveEaseInOut, animations: {
            constraint.constant = constant
            completion()
        })
    }
}
