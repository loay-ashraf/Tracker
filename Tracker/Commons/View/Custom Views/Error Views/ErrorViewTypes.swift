//
//  ErrorViewTypes.swift
//  GitIt
//
//  Created by Loay Ashraf on 20/02/2022.
//

import UIKit

struct ErrorViewModel {
    
    var image: UIImage?
    var title: String
    var message: String
    
    init(image: UIImage?, title: String, message: String) {
        self.image = image
        self.title = title
        self.message = message
    }
    
    init?(from error: Error) {
        if error.self is DataError {
            self = ErrorConstants.Data.viewModel
            return
        }
        return nil
    }
    
}
