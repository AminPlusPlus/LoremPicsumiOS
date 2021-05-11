//
//  CacheService.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/9/21.
//

import UIKit

final class CacheService  {
    
    static let shared = CacheService()
    
    private init(){}
    
    //Cache Images
    let images  = NSCache<NSString, UIImage>()
}

