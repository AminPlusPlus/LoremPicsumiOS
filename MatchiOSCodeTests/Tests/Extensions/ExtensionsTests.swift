//
//  ExtensionsTests.swift
//  MatchiOSCodeTests
//
//  Created by Aminjoni Abdullozoda on 5/10/21.
//

import XCTest
@testable import MatchiOSCode

class ExtensionsTests : XCTestCase {
    
    func testRemoveVowels() throws {
        let text = "Amin"
        XCTAssertEqual(text.removeVowels(), "mn","Mismatch removing vowels from string")
    }
}
