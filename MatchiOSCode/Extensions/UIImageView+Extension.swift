//
//  UIImageView+Extension.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/9/21.
//

import UIKit

fileprivate let cache = CacheService.shared.images
extension UIImageView {
    func load(url: URL) {
        
        let keyCache = NSString(string: url.absoluteString)
        if let image = cache.object(forKey: keyCache) {
            DispatchQueue.main.async {
                self.image = image.roundedImage
            }
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cache.setObject(image, forKey: keyCache)
                        self?.image = image.roundedImage
                    }
                }
            }
        }
    }
}
