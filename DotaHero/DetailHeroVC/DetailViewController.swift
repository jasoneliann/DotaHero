//
//  DetailViewController.swift
//  DotaHero
//
//  Created by Jason Elian on 27/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation
import UIKit


protocol PickedHeroViewControllerConfig {
    /// The hero that will be appear on the view.
    /// - Parameters:
    ///   - pickedHero: The picked hero.
    ///   - altHeroes: The alternative hero of each hero Type.
    func setupProperties(pickedHero: MDotaHero?, altHeroes: [MDotaHero]?)
    
    /// Returns the pickedHero.
    var pickedHero: MDotaHero { get }
    
    /// Returns the alternative heroes.
    var altHeroes: [MDotaHero] { get }
}

final
class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private var aPickedHero: MDotaHero!
    private var theAltHeroes: [MDotaHero] = []
    
    // MARK: - Components
    private
    lazy var contentView: DetailView = {
        let view: DetailView = DetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Internal init
    init(pickedHero: MDotaHero) {
        self.aPickedHero = pickedHero
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("APickedHero Havent setted")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.contentView.setupProperties(pickedHero: self.aPickedHero, altHeroes: nil)
        self.title = self.aPickedHero.name
        setupLayouts()
    }
}

extension DetailViewController {
    private func setupViews() {
        view.backgroundColor = .white
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

extension DetailViewController: PickedHeroViewControllerConfig {
    func setupProperties(pickedHero: MDotaHero? = nil, altHeroes: [MDotaHero]? = nil) {
        if let unwrappedHero: MDotaHero = pickedHero {
            self.aPickedHero = unwrappedHero
        }
        
        if let unwrappedAltHeroes: [MDotaHero] = altHeroes {
            self.theAltHeroes = unwrappedAltHeroes
        }
        
        
        self.contentView.setupProperties(pickedHero: aPickedHero, altHeroes: theAltHeroes)
    }
    
    var pickedHero: MDotaHero {
        return self.aPickedHero
    }
    
    var altHeroes: [MDotaHero] {
        return self.theAltHeroes
    }
}
