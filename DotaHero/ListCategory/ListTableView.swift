//
//  ListTableView.swift
//  DotaHero
//
//  Created by Jason Elian on 26/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation
import UIKit

protocol ListTableViewConfig {
    /// Set items in `tableView`.
    /// - Parameter items: `Items` that will be appear in the `tableView`.
    func setItems(items: [String])
    
    /// Returns the all items.
    var items: [String] { get }
}

final
class ListTableView: UIView {
    
    // MARK: - Properties
    private var theItems: [String] = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let CELL_ID: String = "cellId"
    weak var delegate: DotaCollectionDelegate?
    
    // MARK: - Components
    private
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Default Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupLayouts()
    }
}

extension ListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell: CategoryCell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
                as? CategoryCell else {
            return UITableViewCell()
        }
        
        let selectedItem: String = self.theItems[indexPath.row]
        cell.setLabel(selectedItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(indexAtRow: indexPath.row, onViewController: nil)
    }
}

extension ListTableView {
    private func setupViews() {
        addSubview(tableView)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CELL_ID)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension ListTableView: ListTableViewConfig {
    func setItems(items: [String]) {
        self.theItems = items
    }
    
    var items: [String] {
        return self.theItems
    }
}
