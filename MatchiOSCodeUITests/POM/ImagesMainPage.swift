//
//  ImagesMainPage.swift
//  MatchiOSCodeUITests
//
//  Created by Aminjoni Abdullozoda on 5/10/21.
//

import UIKit
import XCTest
@testable import MatchiOSCode

final class ImagesMainPage {
    fileprivate var app  : XCUIApplication!
    
    //MARK: Elements
    private var collectionView : XCUIElement {return app.collectionViews.element(matching: .collectionView, identifier: AccessibilityIdentifiers.AXImagesMainView.ImagesMainViewCollection)}
    private var labelTitle : XCUIElement {return app.staticTexts.element(matching: .any, identifier: AccessibilityIdentifiers.AXImagesMainView.ImagesMainViewTitle)}
    private var getMoreButton : XCUIElement {return app.buttons.element(matching: .button, identifier: AccessibilityIdentifiers.AXImagesMainView.Button.GetMoreImagesButton)}
    private func collectionViewCellAuthorTitle (by bound : Int = 0)  ->  XCUIElement {return app.cells.element(boundBy: bound).staticTexts.element(matching: .any, identifier: AccessibilityIdentifiers.AXImagesMainView.Cell.AuthorLabel)}

    
    //MARK: Actions
    init(app : XCUIApplication) {
        self.app = app
    }
    
    @discardableResult
    func tapGetMoreImagesButton() -> ImagesMainPage {
        _ = getMoreButton.waitForExistence(timeout: 2)
        getMoreButton.tap()
        return self
    }
    
    @discardableResult
    func swipeRightCollection() -> ImagesMainPage {
        _ = collectionView.waitForExistence(timeout: 2)
        collectionView.swipeRight()
        return self
    }
    @discardableResult
    func swipeLeftCollection() -> ImagesMainPage {
        _ = collectionView.waitForExistence(timeout: 2)
        collectionView.swipeLeft()
        return self
    }
    @discardableResult
    func tapOnCollectionCell(by index : Int = 0) -> ImagesMainPage {
        _ = collectionView.cells.element(boundBy: index).waitForExistence(timeout: 2)
        collectionView.cells.element(boundBy: index).tap()
        return self
    }
    
    //MARK: Asserts
    @discardableResult
    func assertTitleLabelExist(isExist : Bool = true) -> ImagesMainPage {
        _ = labelTitle.waitForExistence(timeout:2)
        XCTAssertEqual(labelTitle.exists, isExist, "Title label doesn't exist")
        return self
    }
    
    @discardableResult
    func assertCollectionViewExist (isExist : Bool = true) -> ImagesMainPage {
        _ = collectionView.waitForExistence(timeout: 2)
        XCTAssertEqual(collectionView.exists, isExist)
        return self
    }
    
    @discardableResult
    func assertCellAuthorExist (isExist : Bool = true, by bound : Int) -> ImagesMainPage {
        _ = collectionViewCellAuthorTitle(by: bound).waitForExistence(timeout: 2)
        XCTAssertEqual(collectionViewCellAuthorTitle(by: bound).exists, isExist, "Author Label doesn't exist")
        return self
    }
    
    @discardableResult
    func assertGetMoreButtonExist (isExist : Bool = true) -> ImagesMainPage {
        _ = getMoreButton.waitForExistence(timeout: 2)
        XCTAssertEqual(getMoreButton.exists, isExist,"Doesn't Exist get more button")
        return self
    }
    
}
