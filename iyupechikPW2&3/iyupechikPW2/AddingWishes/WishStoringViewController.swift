//
//  WishStoringViewController.swift
//  iyupechikPW2
//
//  Created by Печик Ирина on 13.11.2023.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // Наша табличка.
    let table: UITableView = UITableView(frame: .zero)
    // Этот массив будет хранить наши желания в пределах одной сессии приложения.
    private var wishArray: [String] = []
    private let defaults = UserDefaults.standard
    
    private enum Constants {
        static let numberOfSections: Int = 2
        static let wishesKey: String = "AddWishCell"
        static let viewBackroundColor: String = "#F16C97"
        static let tableBackroundColor: String = "#7375D8"
    }
    
    override func viewDidLoad() {
        // Помещаем желания в массив.
        if let savedWishes = defaults.array(forKey: Constants.wishesKey) as? [String] {
            wishArray = savedWishes
        }
        view.backgroundColor = convertHexCodeStringToUIColor(hex: Constants.viewBackroundColor)
        // Добавляем таблицу.
        configureTable()
    }
    
    private func configureTable() {
        table.delegate = self
        table.dataSource = self
        view.addSubview(table)
        table.backgroundColor = convertHexCodeStringToUIColor(hex: Constants.tableBackroundColor)
        table.separatorStyle = .none
        table.layer.cornerRadius = 20
        table.pin(to: view, 20)
        table.delaysContentTouches = false
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    
    // Количество ячеек в секции.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return wishArray.count
        }
        return 1
    }
    // Получение объекта ячейки.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            // Регестрируем нашу ячейку.
            table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            
            // Приводим к типу кастомной ячейки.
            guard let wishCell = cell as? WrittenWishCell else {return cell}
            wishCell.configure(with: wishArray[indexPath.row])
            
            // Замыкание для дальнейшего изменений ячейки.
            wishCell.editWish = { [weak self] editWish, newWish in
                let id = self?.wishArray.firstIndex(of: editWish)
                self?.wishArray[id!] = newWish
                self?.table.reloadData()
                self?.defaults.set(self?.wishArray, forKey: Constants.wishesKey)
            }
            return wishCell
        } else {
            // Регистрируем нашу ячейку.
            table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
            guard let addCell = cell as? AddWishCell else {return cell}
            
            // Замыкание для добавления желания.
            addCell.addWish = { [weak self] newWish in
                self?.wishArray.append(newWish)
                self?.table.reloadData()
                self?.defaults.set(self?.wishArray, forKey: Constants.wishesKey)
            }
            return addCell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Получаем ячейку по индексу
        let cell = tableView.cellForRow(at: indexPath)
        // Если ячейка является AddWishCell, то запрещаем редактирование.
        if cell is AddWishCell {
            return false
        }
        // Для всех остальных ячеек (для WrittenWishCell) разрешаем редактирование.
        return true
    }
    
    // Количество секций.
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
}

// MARK: - UITableViewDelegate
extension WishStoringViewController: UITableViewDelegate {
    // MARK: Добавление свайпов ячейки.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionEdit = UIContextualAction(style: .normal, title: "Edit wish") {
            (action, view, completionHandler) in
            completionHandler(true)
            let cell = tableView.cellForRow(at: indexPath) as! WrittenWishCell
            cell.Edit()
        }
        actionEdit.backgroundColor = .systemGreen
        
        let actionDelete = UIContextualAction(style: .normal, title: "Delete wish") {
            (action, view, completionHandler) in
            completionHandler(true)
            // Удаление элемента из массива
            self.wishArray.remove(at: indexPath.row)
            // Удаление ячейки из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
            // Сохранение изменений в UserDefaults
            UserDefaults.standard.set(self.wishArray, forKey: Constants.wishesKey)
        }
        actionDelete.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [actionEdit, actionDelete])
    }
}

