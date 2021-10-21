//
//  Extensions+UIView.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func viewCorner(_ radius: CGFloat? = nil) {
        layer.cornerRadius = radius ?? self.frame.height / 2
        layer.masksToBounds = true
    }
    
    func viewBorder(color: UIColor = .white, width: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    class var identifier: String {
        return String(describing: self)
    }
}
