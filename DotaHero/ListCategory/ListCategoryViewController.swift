//
//  ListCategoryViewController.swift
//  DotaHero
//
//  Created by Jason Elian on 26/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation
import UIKit

protocol ListCategoryViewControllerConfig {
    /// Get the items of the category list.
    var items: [String] { get }
}

final
class ListCategoryViewController: UIViewController {
    
    // MARK: - Properties
    private var theItems: [String] = [] {
        didSet {
            contentView.setItems(items: theItems)
        }
    }
    weak var delegate: DotaCollectionDelegate?
    
    // MARK: - Components
    private
    lazy var contentView: ListTableView = {
        let view: ListTableView = ListTableView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Default Functions
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        self.contentView.setItems(items: theItems)
    }
}

extension ListCategoryViewController {
    private func setupViews() {
        view.addSubview(contentView)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ListCategoryViewController: DotaHeroConfig {
    func setItems(items: [MDotaHero]) {
        var uniqueKeys: [String] = []
        
        items.forEach { (item) in
            for role in item.roles where !uniqueKeys.contains(role.rawValue) {
                uniqueKeys.append(role.rawValue)
            }
        }
        
        self.theItems = uniqueKeys
    }
}

extension ListCategoryViewController: DotaCollectionDelegate {
    func didSelect(indexAtRow index: Int, onViewController vc: UIViewController?) {
        delegate?.didSelect(indexAtRow: index, onViewController: self)
    }
}

extension ListCategoryViewController: ListCategoryViewControllerConfig {
    var items: [String] {
        return self.theItems
    }
}
