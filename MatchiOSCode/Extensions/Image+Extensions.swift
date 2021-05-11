//
//  Image+Extensions.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/9/21.
//

import UIKit

extension UIImage {
    
    ///Clip image rounded before using it
    var roundedImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.allCorners],
            cornerRadii: CGSize(width: 10.0, height: 10.0)
            ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }

}
