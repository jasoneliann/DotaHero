//
//  DetailView.swift
//  DotaHero
//
//  Created by Jason Elian on 27/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation
import UIKit

final
class DetailView: UIView {
    
    // MARK: - Properties
    private let MAIN_MARGIN: CGFloat = 16
    private var aPickedHero: MDotaHero! {
        didSet {
            pickedHeroView.pickedHeroView(pickedHero: aPickedHero)
        }
    }
    private var theAltHeroes: [MDotaHero] = [] {
        didSet {
            generateAltHeroes(altHeroes: theAltHeroes)
        }
    }
    
    // MARK: - Components
    private
    lazy var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private
    lazy var stackViewAltHero: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private
    lazy var pickedHeroView: PickedHeroView = {
        let pickedHero: PickedHeroView = PickedHeroView()
        pickedHero.translatesAutoresizingMaskIntoConstraints = false
        return pickedHero
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

extension DetailView {
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(pickedHeroView)
        scrollView.addSubview(stackViewAltHero)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pickedHeroView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            pickedHeroView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: MAIN_MARGIN),
            pickedHeroView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackViewAltHero.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewAltHero.topAnchor.constraint(equalTo: pickedHeroView.bottomAnchor, constant: MAIN_MARGIN),
            stackViewAltHero.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackViewAltHero.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func generateAltHeroes(altHeroes: [MDotaHero]) {
        altHeroes.forEach { (hero) in
            let view: HeroView = HeroView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.setupContent(image: UIImage(data: hero.image ?? Data()) , heroName: hero.name)
            self.stackViewAltHero.addArrangedSubview(view)
        }
    }
}

extension DetailView: PickedHeroViewControllerConfig {
    func setupProperties(pickedHero: MDotaHero? = nil, altHeroes: [MDotaHero]? = nil) {
        self.aPickedHero = pickedHero
        self.theAltHeroes = altHeroes ?? []
    }
    
    var pickedHero: MDotaHero {
        return self.aPickedHero
    }
    
    var altHeroes: [MDotaHero] {
        return self.theAltHeroes
    }
}
