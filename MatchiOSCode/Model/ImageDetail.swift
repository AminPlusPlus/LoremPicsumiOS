//
//  ImageDetail.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/8/21.
//

import Foundation

struct ImageDetail : Codable {
    let id           : String
    let author       : String?
    let width        : Int
    let height       : Int
    let url          : String
    let download_url : String
}
