//
//  ImageDetailTests.swift
//  MatchiOSCodeTests
//
//  Created by Aminjoni Abdullozoda on 5/10/21.
//

import XCTest
@testable import MatchiOSCode

class ImageDetailTests : XCTestCase {
    
    func testDecodeImageDetail () throws {
        let imageDetail = try ImageDetailTests.createImageDetaileFromJSON()
        XCTAssertEqual(imageDetail.id, "0")
        XCTAssertEqual(imageDetail.author, "Alejandro Escamilla")
        XCTAssertEqual(imageDetail.width, 5616)
        XCTAssertEqual(imageDetail.url, "https://unsplash.com/...")
        XCTAssertEqual(imageDetail.download_url, "https://picsum.photos/...")
    }
    
    
    static func createImageDetaileFromJSON() throws -> ImageDetail {
        return try UnitTestHelpers.sharedJSONDecoder.decode(ImageDetail.self, from: ImageDetailTests.ImageDetailJSON)
    }
    //MARK:-  JSON Datas
    static let ImageDetailJSON =  """
    {
    "id": "0",
    "author": "Alejandro Escamilla",
    "width": 5616,
    "height": 3744,
    "url": "https://unsplash.com/...",
    "download_url": "https://picsum.photos/..."
    }
    """.data(using: .utf8)!
    
}
