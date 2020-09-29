//
//  HeroView.swift
//  DotaHero
//
//  Created by Jason Elian on 27/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation
import UIKit

protocol HeroViewConfig {
    /// Setup hero view.
    /// - Parameters:
    ///   - image: The `image` of thehero.
    ///   - heroName: The `text` of the hero name.
    func setupContent(image: UIImage?, heroName: String?)
    
    /// Returns the `imageHero` of the imageView.
    var image: UIImage? { get }
    
    /// Returns the `heroName` of the titleLabel.
    var name: String? { get }
}

final
class HeroView: UIView {
    
    // MARK: - Properties
    private let MAIN_MARGIN: CGFloat = 16
    private let TITLE_MARGIN: CGFloat = 8
    private let IMAGE_SIZE: CGSize = CGSize(width: 50, height: 50)
    
    private var anImage: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.imageView.image = self.anImage
            }
        }
    }
    private var aName: String? {
        didSet {
            self.heroName.text = aName
        }
    }
    
    
    // MARK: - Components
    private
    lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private
    lazy var heroName: UILabel = {
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

extension HeroView {
    private func setupViews() {
        addSubview(imageView)
        addSubview(heroName)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MAIN_MARGIN),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: MAIN_MARGIN),
            imageView.widthAnchor.constraint(greaterThanOrEqualToConstant: IMAGE_SIZE.width),
            imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: IMAGE_SIZE.height),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MAIN_MARGIN),
        ])
        
        NSLayoutConstraint.activate([
            heroName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MAIN_MARGIN),
            heroName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: TITLE_MARGIN),
            heroName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MAIN_MARGIN),
        ])
        
        bottomAnchor.constraint(equalTo: heroName.bottomAnchor, constant: MAIN_MARGIN).isActive = true
    }
}

extension HeroView: HeroViewConfig {
    func setupContent(image: UIImage?, heroName: String?) {
        self.anImage = image
        self.aName = heroName
    }
    
    var image: UIImage? {
        return self.anImage
    }
    
    var name: String? {
        return self.aName
    }
}
