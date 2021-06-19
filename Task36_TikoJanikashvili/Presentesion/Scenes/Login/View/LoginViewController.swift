//
//  LoginViewController.swift
//  Task36_TikoJanikashvili
//
//  Created by Tiko on 18.06.21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var username: UITextField!
    @IBOutlet private weak var password: UITextField!
    
    // MARK: - Private Properties
    private var viewModel: LoginViewModelProtocol!
    private var coreDataManager: CoreDataManagerProtocol!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewModel()
    }
   
    private func configureViewModel() {
        self.coreDataManager = CoreDataManager()
        self.viewModel = LoginViewModel(coreDataManager: self.coreDataManager)
    }
    
    // MARK: - IBActions
    @IBAction func register(_ sender: Any) {
        let sb = UIStoryboard(name: "RegisterViewController", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "RegisterViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func login(_ sender: Any) {
        self.viewModel.login(with: self.username.text ?? "", and: self.password.text ?? "") { result in
            switch result {
            case .success(let user):
                guard let user = user else { return }
                self.password.text = ""
                self.username.text = ""
                let sb = UIStoryboard(name: "MainViewController", bundle: nil)
                if let vc = sb.instantiateViewController(identifier: "MainViewController") as? MainViewController {
                    vc.user = user
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error)
                let alert = UIAlertController(title: "Oops", message: "\(error)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
