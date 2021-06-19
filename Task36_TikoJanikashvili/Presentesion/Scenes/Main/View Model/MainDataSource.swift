//
//  MainDataSource.swift
//  Task36_TikoJanikashvili
//
//  Created by Tiko on 18.06.21.
//

import UIKit

class MainDataSource: NSObject, UITableViewDataSource {
    // MARK: - Private Properties
    private var tableView: UITableView!
    private var viewModel: MainViewModelProtocol!
    private var mails: [Mail] = []
    private var selector = Selector.inbox
    
    init(with tableView: UITableView, viewModel: MainViewModelProtocol) {
        super.init()
        self.tableView = tableView
        self.viewModel = viewModel
        self.tableView.dataSource = self
    }
    
    func refresh(with selector: Selector) {
        self.selector = selector
        self.viewModel.fetchMails(for: viewModel.user) { mails in
            self.mails = mails
            self.tableView.reloadData()
        }
    }
    
    func loadInbox(with selector: Selector) {
        self.selector = selector
        //        self.viewModel.fetchAllMails { mails in
        //            self.mails = mails
        //            self.tableView.reloadData()
        //        }
        self.viewModel.fetchRecieved(user: viewModel.user) {  mails in
            self.mails = mails
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.mails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(MainCell.self, for: indexPath)
        cell.setCell(with: self.mails[indexPath.row], user: self.viewModel.user, selector: self.selector)
        return cell
    }
}
