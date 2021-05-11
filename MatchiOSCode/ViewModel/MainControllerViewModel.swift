//
//  MainControllerViewModel.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/9/21.
//

import UIKit

final class MainControllerViewModel : MainViewModelType {
    
    //MARK:- Properties
    private var images = [ImageDetail]()
    private let apiService : ApiService
   
    var numberOfRows: Int {
        return images.count
    }
    weak var delegate: MainCollectionViewModelDelegate?
    
    //MARK:- Init
    init(service : ApiService) {
        self.apiService = service
    }
    
    //MARK:- Methods
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ImageCellViewModelType? {
        let imageDetail = images[indexPath.row]
        return ImageCellViewModel(imageDetail : imageDetail)
    }
    
    /// Following method is for fetch `Images Detail`
    /// - Parameter page: `Page` should be minimum `1`
    func fetchImages(page: Int) {
        delegate?.willLoadData()
        apiService.getListOfPictures(page: page) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let images):
                self.images.append(contentsOf: images)
                self.delegate?.didLoadData()
            case .failure(let error):
                self.delegate?.didLoadDataFailed(error: error)
            }
        }
    }
}
