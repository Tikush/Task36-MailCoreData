//
//  NewMailViewModel.swift
//  Task36_TikoJanikashvili
//
//  Created by Tiko on 18.06.21.
//

import Foundation

protocol NewMailViewModelProtocol: AnyObject {
    func saveMail(with subject: String, content: String, user: User, sentToUser: String, completion: @escaping ((Bool) -> Void))
    init(coreDataManager: CoreDataManagerProtocol)
}

final class NewMailViewModel: NewMailViewModelProtocol {
   
    // MARK: - Private Properties
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func saveMail(with subject: String, content: String, user: User, sentToUser: String, completion: @escaping ((Bool) -> Void)) {
        self.coreDataManager.saveMail(with: subject, content: content, user: user, sentToUser: sentToUser, completion: completion)
    }
}
