//
//  CoreDataManager.swift
//  Task36_TikoJanikashvili
//
//  Created by Tiko on 18.06.21.
//

import UIKit
import CoreData

protocol CoreDataManagerProtocol: AnyObject {
    func login(with username: String, and password: String, complition: @escaping((Result<User?, UserError>) -> Void))
    func register(with username: String, and password: String, name: String, complition: @escaping(Bool) -> Void)
    func saveMail(with subject: String, content: String, user: User, sentToUser: String, completion: @escaping ((Bool) -> Void))
    func fetchSentMails(for user: User?, completion: @escaping ([Mail]) -> Void)
    func fetchRecievedMails(completion: @escaping ([Mail]) -> Void)
    func fetchRecieved(user: User?, completion: @escaping ([Mail]) -> Void)
    var context: NSManagedObjectContext? { get }
}

extension CoreDataManagerProtocol {
    var context: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
}

class CoreDataManager: CoreDataManagerProtocol {
    func register(with username: String, and password: String, name: String, complition: @escaping (Bool) -> Void) {
        guard let context = context else { return }
        let user = User(context: context)
        user.name = name
        user.password = password
        user.username = username
        do {
            try context.save()
            complition(true)
        } catch {
            complition(false)
            print(error)
        }
    }
    
    func login(with username: String, and password: String, complition: @escaping ((Result<User?, UserError>) -> Void)) {
        guard let context = context else { return }
        
        do {
            let predicate = NSPredicate(format: "%K = %@", "username", username)
            let request = NSFetchRequest<User>(entityName: "User")
            request.predicate = predicate
            let users = try context.fetch(request)
            if let last = users.last {
                
                if last.username == username && last.password == password {
                    complition(.success(last))
                }
                
            } else {
                complition(.failure(.notFounduser))
            }
        } catch {
            complition(.failure(.unknownError))
        }
    }
    
    func saveMail(with subject: String, content: String, user: User, sentToUser: String, completion: @escaping ((Bool) -> Void)) {
        guard let context = context else { return }
        let mail = Mail(context: context)
        mail.subject = subject
        mail.content = content
        mail.user = user
        mail.sendTo = sentToUser
        
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func fetchSentMails(for user: User?, completion: @escaping ([Mail]) -> Void) {
        guard let context = context,
              let user = user,
              let password = user.password else { return }
        do {
            let predicate = NSPredicate(format: "user.password == %@", password)
            let request = NSFetchRequest<Mail>(entityName: "Mail")
            request.predicate = predicate
            
            let mails = try context.fetch(request)
            completion(mails)
        } catch {
            completion([])
        }
    }
    
    func fetchRecievedMails(completion: @escaping ([Mail]) -> Void) {
        guard let context = context else { return }
        
        do {
            let request = NSFetchRequest<Mail>(entityName: "Mail")
            
            let mails = try context.fetch(request)
            completion(mails)
        } catch {
            completion([])
        }
    }
    
    func fetchRecieved(user: User?, completion: @escaping ([Mail]) -> Void) {
        guard let context = context, let user = user, let name = user.username else { return }
       
        do {
            let predicate = NSPredicate(format: "sendTo == %@", name)
            let request = NSFetchRequest<Mail>(entityName: "Mail")
            request.predicate = predicate
            
            let mails = try context.fetch(request)
            for item in mails {
                print(item.user?.username)
            }
            completion(mails)
        } catch {
            completion([])
        }
    }
}

enum UserError: Error {
    case notFounduser
    case unknownError
}
