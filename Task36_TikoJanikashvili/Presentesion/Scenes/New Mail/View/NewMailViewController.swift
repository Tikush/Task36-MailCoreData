//
//  NewMailViewController.swift
//  Task36_TikoJanikashvili
//
//  Created by Tiko on 18.06.21.
//

import UIKit

class NewMailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var content: UITextField!
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var toUsername: UITextField!
    
    // MARK: - Private Properties
    private var viewModel: NewMailViewModel!
    private var coreDataManager: CoreDataManagerProtocol!
    
    // MARK:  - Internal Properties
    var user: User?
    var selector: Selector = .inbox
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewModel()
    }
    
    @IBAction func send(_ sender: Any) {
        self.viewModel.saveMail(with: self.subject.text ?? "", content: self.content.text ?? "", user: user!, sentToUser: self.toUsername.text ?? "") { success in
            if success {
                self.navigationController?.popViewController(animated: true)
            } else {
                let alert = UIAlertController(title: "Warning", message: "Uknonw error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    private func configureViewModel() {
        self.coreDataManager = CoreDataManager()
        self.viewModel = NewMailViewModel(coreDataManager: self.coreDataManager)
    }
}
