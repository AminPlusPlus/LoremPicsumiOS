//
//  MainCollectionViewModelDelegate.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/9/21.
//

import Foundation

protocol MainCollectionViewModelDelegate : class {
    func willLoadData()
    func didLoadData()
    func didLoadDataFailed(error : MatchError)
}
