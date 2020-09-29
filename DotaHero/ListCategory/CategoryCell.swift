//
//  CategoryCell.swift
//  DotaHero
//
//  Created by Jason Elian on 26/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation
import UIKit

protocol CategoryCellConfig {
    /// Set the label inside the cell.
    /// - Parameter text: `String` that will be appear on the cell.
    func setLabel(_ text: String?)
    
    /// Returns the text inside the cell.
    var textValue: String { get }
}

final
class CategoryCell: UITableViewCell {
    
    // MARK: - Properties
    private let MAIN_MARGIN: CGFloat = 16
    private var aText: String = "" {
        didSet {
            self.mainLabel.text = aText
        }
    }
    
    // MARK: - Components
    private
    let mainLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "label"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Default Functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupLayouts()
    }
}

extension CategoryCell {
    private func setupViews() {
        addSubview(mainLabel)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MAIN_MARGIN),
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: MAIN_MARGIN),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MAIN_MARGIN)
        ])
        
        bottomAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: MAIN_MARGIN).isActive = true
    }
}

extension CategoryCell: CategoryCellConfig {
    func setLabel(_ text: String?) {
        self.aText = text ?? ""
    }
    
    var textValue: String {
        return self.aText
    }
}
