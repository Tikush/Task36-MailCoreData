//
//  LoginViewModel.swift
//  Task36_TikoJanikashvili
//
//  Created by Tiko on 18.06.21.
//

import Foundation

protocol LoginViewModelProtocol: AnyObject {
    func login(with username: String, and password: String, complition: @escaping((Result<User?, UserError>) -> Void))
    init(coreDataManager: CoreDataManagerProtocol)
}

final class LoginViewModel: LoginViewModelProtocol {
    
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func login(with username: String, and password: String, complition: @escaping ((Result<User?, UserError>) -> Void)) {
        self.coreDataManager.login(with: username, and: password, complition: complition)
    }
}
