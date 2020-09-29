//
//  DotaHeroCell.swift
//  DotaHero
//
//  Created by Jason Elian on 26/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation
import UIKit

protocol DotaHeroCellConfig {
    /// Setup content of the cell.
    /// - Parameters:
    ///   - image: The `image` that will appear on the cell.
    ///   - title: The `text` of the image description.
    func setupContent(image: UIImage?, title: String?)
    
    /// Returns the `imageValue` of the imageView.
    var imageValue: UIImage? { get }
    
    /// Returns the `titleValue` of the titleLabel.
    var titleValue: String? { get }
}

final
class DotaHeroCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let MAIN_MARGIN: CGFloat = 16
    private let TITLE_MARGIN: CGFloat = 8
    private let IMAGE_SIZE: CGSize = CGSize(width: 50, height: 50)
    
    private var anImage: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.mainImageView.image = self.anImage
            }
        }
    }
    private var aTitle: String? {
        didSet {
            self.titleLabel.text = aTitle
        }
    }
    
    // MARK: - Components
    private
    let mainImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Title"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

extension DotaHeroCell {
    private func setupViews() {
        addSubview(mainImageView)
        addSubview(titleLabel)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MAIN_MARGIN),
            mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: MAIN_MARGIN),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MAIN_MARGIN),
            mainImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: IMAGE_SIZE.width),
            mainImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: IMAGE_SIZE.height)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MAIN_MARGIN),
            titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: TITLE_MARGIN),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MAIN_MARGIN)
        ])
    }
}

extension DotaHeroCell: DotaHeroCellConfig {
    func setupContent(image: UIImage?, title: String?) {
        self.anImage = image
        self.aTitle = title
    }
    
    var imageValue: UIImage? {
        return self.anImage
    }
    
    var titleValue: String? {
        return self.aTitle
    }
}
