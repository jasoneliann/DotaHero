//
//  MainAppViewController.swift
//  DotaHero
//
//  Created by Jason Elian on 26/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation
import UIKit

final
class MainAppViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var dotaHeroVc: DotaHeroViewController = {
        let vc: DotaHeroViewController = DotaHeroViewController()
        vc.delegate = self
        return vc
    }()
    private lazy var categoryVc: ListCategoryViewController = {
        let vc: ListCategoryViewController = ListCategoryViewController()
        vc.delegate = self
        return vc
    }()
    var theItems: [MDotaHero] = [] {
        didSet {
            dotaHeroVc.setItems(items: self.theItems)
            categoryVc.setItems(items: self.theItems)
        }
    }
    
    // MARK: - Components
    private
    let stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private
    let label: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Hello"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        hitAPI()
    }
}

extension MainAppViewController {
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(stackView)

        addChild(dotaHeroVc)
        addChild(categoryVc)
        
        stackView.addArrangedSubview(categoryVc.view)
        stackView.addArrangedSubview(dotaHeroVc.view)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            categoryVc.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func hitAPI() {
        guard let url: URL = URL(string: "https://api.opendota.com/api/herostats") else { return }
        
        let request: URLRequest = URLRequest(url: url)
        Netwroking.shared.request(url: request) { [weak self] (data, error) in
            
            guard let unwrappedData: Data = data,
                let result = try? JSONDecoder().decode([MDotaHero].self, from: unwrappedData) else { return }
            self?.theItems = result
            
            self?.getImages()
        }
    }
    
    private func getImages() {
        self.theItems.enumerated().forEach { (index, item) in
            Netwroking.shared.downloadImage(url: item.imageUrl!.absoluteString) { (data) in
                item.image = data
                
                guard let unwrappedData: Data = data else { return }
                self.dotaHeroVc.setImage(withIndex: index, image: UIImage(data: unwrappedData))
            }
        }
    }
}

extension MainAppViewController: DotaCollectionDelegate {
    func didSelect(indexAtRow index: Int, onViewController vc: UIViewController?) {
        if vc is ListCategoryViewController {
            self.filterByRole(withIndex: index)
        } else {
            self.openDetailHero(withIndex: index)
        }
    }
    
    private func filterByRole(withIndex index: Int) {
        guard let role = MDotaHero.Role(rawValue: self.categoryVc.items[index]) else { return }
        
        let resultFilter: [MDotaHero] = theItems.filter { $0.roles.contains(role) }
        self.dotaHeroVc.setItems(items: resultFilter)
        
    }
    
    private func openDetailHero(withIndex index: Int) {
        let selectedItem: MDotaHero = self.theItems[index]
        let vc: DetailViewController = DetailViewController(pickedHero: selectedItem)
        
        vc.setupProperties(altHeroes: self.getAltHeroes(byAttribute: selectedItem.attribute,
                                                        withHeroes: theItems))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getAltHeroes(byAttribute attribute: MDotaHero.Attribute,
                              withHeroes heroes: [MDotaHero]) -> [MDotaHero]
    {
        var result: [ComparedHero] = []
        
        for hero in heroes {
            
            let comparedValue: Int
            
            switch attribute {
            case .agi:
                comparedValue = hero.movementSpeed
            case .int:
                comparedValue = hero.manaPoint
            case .str:
                comparedValue = hero.attackMax
            }
            
            let comparedHero: ComparedHero = ComparedHero(comparedValue: comparedValue, hero: hero)
            
            result = arrangeRanks(ranks: result, withValue: comparedHero)
 
        }
        
        return result.map { $0.hero }
    }
    
    private func isTheHighestAttributes(withHighestHeroAttributes highAttributes: [ComparedHero],
                                        comparedAttribute: Int) -> Bool
    {
        
        for attribute in highAttributes {
            guard attribute.comparedValue > comparedAttribute else { continue }
            return false
        }
        
        return true
    }
    
    
    private func arrangeRanks(ranks: [ComparedHero],
                              withValue value: ComparedHero,
                              maxRanks: Int = 3) -> [ComparedHero]
    {
        
        var result: [ComparedHero] = ranks
        result.append(value)
        result = sortDescending(ranks: result)
        
        if result.count > maxRanks {
            let _ = result.popLast()
        }
        
        return result
    }
    
    private func sortDescending(ranks: [ComparedHero]) -> [ComparedHero] {
        return ranks.sorted { $0.comparedValue > $1.comparedValue }
    }
}

struct ComparedHero {
    let comparedValue: Int
    let hero: MDotaHero
}
