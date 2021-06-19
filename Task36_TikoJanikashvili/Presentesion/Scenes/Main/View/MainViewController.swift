//
//  MainViewController.swift
//  Task36_TikoJanikashvili
//
//  Created by Tiko on 18.06.21.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: -
    var user: User?
    
    // MARK: - Private Properties
    private var viewModel: MainViewModelProtocol!
    private var coreDataManager: CoreDataManagerProtocol!
    private var dataSource: MainDataSource!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.visibleViewController?.navigationItem.title = user?.name
        self.setupLayout()
        self.configureViewModel()
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
    }
    
    private func setupLayout() {
        self.tableView.registerNib(class: MainCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(2)) {
            self.dataSource.loadInbox(with: .inbox)
        }
    }
    
    private func configureViewModel() {
        self.coreDataManager = CoreDataManager()
        self.viewModel = MainViewModel(coreDataManager: self.coreDataManager, user: user)
        self.dataSource = MainDataSource(with: self.tableView, viewModel: self.viewModel)
        self.dataSource.loadInbox(with: .inbox)
    }
    
    @IBAction func sent(_ sender: Any) {
        self.dataSource.refresh(with: .sent)
    }
    
    @IBAction func newMail(_ sender: Any) {
        let sb = UIStoryboard(name: "NewMailViewController", bundle: nil)
        if let vc = sb.instantiateViewController(identifier: "NewMailViewController") as? NewMailViewController {
            vc.user = user
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
