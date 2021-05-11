//
//  ImageCellViewModel.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/9/21.
//

import UIKit

final class ImageCellViewModel: ImageCellViewModelType {
    //MARK:- Properties
    private var imageDetail : ImageDetail!
    var author: String {return imageDetail.author! }
    var downloadURL: URL {
        guard let url = URL(string: "https://picsum.photos/id/\(imageDetail.id)/150/120") else { return Bundle.main.url(forResource: "placeholder", withExtension: "jpg")!}
        return url }
    init(imageDetail : ImageDetail) {
        self.imageDetail = imageDetail
    }
}
