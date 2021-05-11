//
//  MatchError.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/8/21.
//

import Foundation

enum MatchError : String, Error {
    case invalidURL       = "URL msut be a valid"
    case unableToComplete = "Unable to complete please check your internet connection."
    case invalidResponse  = "Invalid response from the server. Please try again."
    case invalidData      = "The data received fromt the server was invalid. Please try again."
    
    var localizedDescription : String {return self.rawValue}
}
