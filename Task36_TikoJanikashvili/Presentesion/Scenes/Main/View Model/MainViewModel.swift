//
//  MainViewModel.swift
//  Task36_TikoJanikashvili
//
//  Created by Tiko on 18.06.21.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    func fetchMails(for user: User?, completion: @escaping ([Mail]) -> Void)
    func fetchAllMails(completion: @escaping ([Mail]) -> Void)
    func fetchRecieved(user: User?, completion: @escaping ([Mail]) -> Void)
    init(coreDataManager: CoreDataManagerProtocol, user: User?)
    var user: User? { get }
}

final class MainViewModel: MainViewModelProtocol {
    
    // MARK: - Private Properties
    private let coreDataManager: CoreDataManagerProtocol
    
    private(set) var user: User?
    
    init(coreDataManager: CoreDataManagerProtocol, user: User?) {
        self.coreDataManager = coreDataManager
        self.user = user
    }
    
    func fetchMails(for user: User?, completion: @escaping ([Mail]) -> Void) {
        self.coreDataManager.fetchSentMails(for: user, completion: completion)
    }
    
    func fetchAllMails(completion: @escaping ([Mail]) -> Void) {
        self.coreDataManager.fetchRecievedMails(completion: completion)
    }
    
    func fetchRecieved(user: User?, completion: @escaping ([Mail]) -> Void) {
        self.coreDataManager.fetchRecieved(user: user, completion: completion)
    }
}
