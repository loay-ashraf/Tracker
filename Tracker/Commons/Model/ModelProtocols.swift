//
//  ModelProtocols.swift
//  GitIt
//
//  Created by Loay Ashraf on 20/02/2022.
//

import Foundation

protocol Model: Equatable {
    
    associatedtype CollectionCellViewModelType: CellViewModel
    
    init()
    init(from collectionCellViewModel: CollectionCellViewModelType)
    
}
