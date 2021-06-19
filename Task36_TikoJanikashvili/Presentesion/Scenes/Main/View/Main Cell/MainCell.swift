//
//  MainCell.swift
//  Task36_TikoJanikashvili
//
//  Created by Tiko on 18.06.21.
//

import UIKit

class MainCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var symbol: UILabel!
    
    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backView.layer.cornerRadius = self.backView.frame.height / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(with item: Mail, user: User?, selector: Selector) {
        guard let username = item.user?.username else { return }
        guard let name = user?.name else { return }
       
        switch selector {
        case .inbox:
            self.symbol.text = "\(String(describing: username.prefix(1)))"
            self.namelabel.text = item.user?.username
            self.subjectLabel.text = item.subject
            self.content.text = item.content
        case .sent:
            self.symbol.text = "\(String(describing: name.prefix(1)))"
            self.namelabel.text = item.user == user ? user?.name : ""
            self.subjectLabel.text = item.sendTo
            self.content.text = item.content
        }
    }
}

enum Selector {
    case inbox
    case sent
}
