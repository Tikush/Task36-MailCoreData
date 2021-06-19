//
//  RegisterViewController.swift
//  Task36_TikoJanikashvili
//
//  Created by Tiko on 18.06.21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    
    // MARK: - Private Properties
    private var viewModel: RegisterViewModel!
    private var codeDataManager: CoreDataManagerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewModel()
    }
    
    private func configureViewModel() {
        self.codeDataManager = CoreDataManager()
        self.viewModel = RegisterViewModel(coreDataManager: self.codeDataManager)
    }
    
    // MARK: - IBActions
    @IBAction func register(_ sender: Any) {
        self.viewModel.register(with: self.username.text ?? "", and: self.password.text ?? "", name: self.name.text ?? "") { success in
            if success {
                print("Registered")
                self.password.text = ""
                self.username.text = ""
                self.name.text = ""
                self.navigationController?.popViewController(animated: true)
            } else {
                print("error")
            }
        }
    }
}
