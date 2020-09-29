//
//  DotaHeroView.swift
//  DotaHero
//
//  Created by Jason Elian on 26/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation
import UIKit

protocol DotaHeroViewConfig {
    /// Set Image in array.
    /// - Parameters:
    ///   - index: `index` of the array.
    ///   - image: `image` of the cell.
    func setImage(withIndex index: Int, image: UIImage?)
    
    /// Returns the items of the collectionView
    var items: [DotaHeroView.HeroListItem] { get }
}

final
class DotaHeroView: UIView {
    
    class HeroListItem {
        let title: String?
        var image: UIImage?
        
        init(title: String?, image: UIImage?) {
            self.title = title
            self.image = image
        }
    }
    
    // MARK: - Properties
    private let CELL_ID: String = "CELL_ID"
    private var theItems: [HeroListItem] = [HeroListItem]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    weak var delegate: DotaCollectionDelegate?
    
    // MARK: - Components
    private
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 200, height: 200)
        let collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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

extension DotaHeroView {
    private func setupViews() {
        addSubview(collectionView)
        
        collectionView.register(DotaHeroCell.self, forCellWithReuseIdentifier: CELL_ID)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension DotaHeroView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.theItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: DotaHeroCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ID, for: indexPath) as? DotaHeroCell else { return UICollectionViewCell() }
        
        let selectedItem: HeroListItem = self.items[indexPath.row]
        cell.setupContent(image: selectedItem.image, title: selectedItem.title)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(indexAtRow: indexPath.item, onViewController: nil)
    }
}

extension DotaHeroView: DotaHeroViewConfig {
    func setItems(items: [HeroListItem]) {
        self.theItems = items
    }
    
    func setImage(withIndex index: Int, image: UIImage?) {
        self.theItems[index].image = image
        self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
    
    var items: [HeroListItem] {
        return self.theItems
    }
}
