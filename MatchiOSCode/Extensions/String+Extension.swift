//
//  String+Extension.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/10/21.
//

import Foundation

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    //set new string without vowels
    func removeVowels() -> String {
        var newstr = ""
        vowelsTraverse(str: &newstr)
        return newstr
    }
    
    //traverse Recursively Remove vowels
    private func vowelsTraverse(str : inout String,val : Int = 0) {
        if val > self.count - 1 {
            return
        }
        
        let indx = self.index(self.startIndex, offsetBy: val)
        let char = self[indx].lowercased()
        if (!(char == "a" || char == "e" || char == "i" || char == "o" || char == "u")) {
            str += char
        }
        return vowelsTraverse(str: &str, val: val + 1)
    }
}
