//
//  RegisterViewModel.swift
//  Task36_TikoJanikashvili
//
//  Created by Tiko on 18.06.21.
//

import Foundation

protocol RegisterViewModelProtocol: AnyObject {
    func register(with username: String, and password: String, name: String, complition: @escaping(Bool) -> Void)
    init(coreDataManager: CoreDataManagerProtocol)
}

final class RegisterViewModel: RegisterViewModelProtocol {
    
    // MARK: - Private Properties
    private let coreDataManager: CoreDataManagerProtocol
    
    // MARK: - Inicilizer
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func register(with username: String, and password: String, name: String, complition: @escaping (Bool) -> Void) {
        self.coreDataManager.register(with: username, and: password, name: name, complition: complition)
    }
}
