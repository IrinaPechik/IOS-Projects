//
//  WishStoringViewController.swift
//  iyupechikPW2
//
//  Created by Печик Дарья on 13.11.2023.
//

import UIKit

class WishStoringViewController: UIViewController {
    private let table: UITableView = UITableView(frame: .zero)
    // Этот массив будет хранить наши желания в пределах одной сессии приложения.
    private var wishArray: [String] = ["I wish to add cells to the table"]
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = 20
        
        table.pin(to: view, 20)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
