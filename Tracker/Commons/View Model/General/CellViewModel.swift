//
//  CellViewModel.swift
//  GitIt
//
//  Created by Loay Ashraf on 21/02/2022.
//

import Foundation

protocol CellViewModel: AnyObject, Hashable {
    
    associatedtype ModelType
    
    var model: ModelType { get }
    
    init()
    init(from model: ModelType)
    
}

extension CellViewModel {
    
    // MARK: - Initialization
    
    init() {
        self.init()
    }
    
}
