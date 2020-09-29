//
//  DotaHeroViewController.swift
//  DotaHero
//
//  Created by Jason Elian on 26/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation
import UIKit

protocol DotaHeroConfig {
    /// Set the items in the viewController.
    /// - Parameter items: The
    func setItems(items: [MDotaHero])
}

protocol DotaCollectionDelegate: AnyObject {
    /// fires when didSelectRowAt is selected
    ///  - Parameter index: `index` of the collection.
    ///  - Parameter viewController: The relatedViewController.
    func didSelect(indexAtRow index: Int, onViewController vc: UIViewController?)
}

final
class DotaHeroViewController: UIViewController {
    
    // MARK: - Properties
    private var theItems: [DotaHeroView.HeroListItem] = [ ] {
        didSet {
            self.contentView.setItems(items: theItems)
        }
    }
    weak var delegate: DotaCollectionDelegate?
    
    // MARK: - Components
    private
    lazy var contentView: DotaHeroView = {
        let view: DotaHeroView = DotaHeroView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
}

extension DotaHeroViewController {
    private func setupViews() {
        view.backgroundColor = .white
        title = "Dota Hero"
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

extension DotaHeroViewController: DotaHeroConfig {
    func setItems(items: [MDotaHero]) {
        self.theItems = items.map { (item) in
            guard let data: Data = item.image else {
                return DotaHeroView.HeroListItem(title: item.name, image: nil)
            }
            return DotaHeroView.HeroListItem(title: item.name, image: UIImage(data: data))
        }
    }
}

extension DotaHeroViewController: DotaHeroViewConfig {
    func setItems(items: [DotaHeroView.HeroListItem]) {
        self.theItems = items
    }
    
    func setImage(withIndex index: Int, image: UIImage?) {
        self.theItems[index].image = image
        self.contentView.setImage(withIndex: index, image: image)
    }
    
    var items: [DotaHeroView.HeroListItem] {
        return self.theItems
    }
}

extension DotaHeroViewController: DotaCollectionDelegate {
    func didSelect(indexAtRow index: Int, onViewController vc: UIViewController?) {
        delegate?.didSelect(indexAtRow: index, onViewController: self)
    }
}
