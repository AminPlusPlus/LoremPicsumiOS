//
//  MainViewModelType.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/9/21.
//

import Foundation

protocol MainViewModelType {
    var  numberOfRows : Int {get}
    var  delegate : MainCollectionViewModelDelegate? {get set}
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ImageCellViewModelType?
    func fetchImages(page : Int)
}
