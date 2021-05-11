//
//  MatchiOSCodeUITests.swift
//  MatchiOSCodeUITests
//
//  Created by Aminjoni Abdullozoda on 5/8/21.
//

import XCTest

class MatchiOSCodeUITests: XCTestCase {

    let app  = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVerifyMainPageElementExist() throws {
        _ = ImagesMainPage(app: app)
            .assertTitleLabelExist()
            .assertCollectionViewExist()
            .swipeLeftCollection()
            .swipeRightCollection()
            .assertGetMoreButtonExist()
            .assertCellAuthorExist(by: 0)
    }

}
