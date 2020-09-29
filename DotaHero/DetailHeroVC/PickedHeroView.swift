//
//  PickedHeroView.swift
//  DotaHero
//
//  Created by Jason Elian on 27/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import Foundation
import UIKit

protocol PickedHeroViewConfig {
    /// Set the contentView.
    /// - Parameter pickedHero: The hero that will be appear
    func pickedHeroView(pickedHero: MDotaHero)
    
    /// Returns the `PickedHero`.
    var pickedHero: MDotaHero { get }
}

final
class PickedHeroView: UIView {
    
    // MARK: - Properties
    private let MAIN_MARGIN: CGFloat = 16
    private var aPickedHero: MDotaHero! {
        didSet {
            let separator: String = " : "
            self.setLabelOn(label: typeLabel, withString: A_TYPE_STRING + separator + "\(aPickedHero.type.rawValue)")
            self.setLabelOn(label: attributeLabel, withString: AN_ATTRIBUTE_STRING + separator + "\(aPickedHero.attribute.rawValue)")
            self.setLabelOn(label: healthLabel, withString: A_HEALTH_STRING + separator + "\(aPickedHero.health)")
            self.setLabelOn(label: attackLabel, withString: AN_ATTACK_STRING + separator + "\(aPickedHero.attackMax)")
            self.setLabelOn(label: speedLabel, withString: A_SPEED_STRING + separator + "\(aPickedHero.movementSpeed)")
            self.setLabelOn(label: rolesLabel, withString: A_ROLE_STRING + separator + "\(aPickedHero.roles.reduce("") { $0 + $1.rawValue + ", " })")
            
            
            guard let data: Data = aPickedHero.image else {
                heroView.setupContent(image: nil, heroName: aPickedHero.name)
                return
            }
            heroView.setupContent(image: UIImage(data: data), heroName: aPickedHero.name)
        }
    }
    
    private let A_TYPE_STRING: String = "Type"
    private let AN_ATTRIBUTE_STRING: String = "Attribute"
    private let A_HEALTH_STRING: String = "Health"
    private let AN_ATTACK_STRING: String = "Max Attack"
    private let A_SPEED_STRING: String = "Speed"
    private let A_ROLE_STRING: String = "Roles"
    
    
    // MARK: - Components
    private
    lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private
    lazy var heroView: HeroView = {
        let heroView: HeroView = HeroView()
        heroView.translatesAutoresizingMaskIntoConstraints = false
        return heroView
    }()
    
    private
    lazy var typeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = A_TYPE_STRING
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private
    lazy var attributeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = AN_ATTRIBUTE_STRING
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private
    lazy var healthLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = A_HEALTH_STRING
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private
    lazy var attackLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = AN_ATTACK_STRING
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private
    lazy var speedLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = A_SPEED_STRING
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private
    lazy var rolesLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = A_ROLE_STRING
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
        fatalError("You can't built in here")
    }
}

extension PickedHeroView {
    private func setupViews() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(heroView)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(attributeLabel)
        stackView.addArrangedSubview(healthLabel)
        stackView.addArrangedSubview(attackLabel)
        stackView.addArrangedSubview(speedLabel)
        stackView.addArrangedSubview(rolesLabel)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MAIN_MARGIN),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: MAIN_MARGIN),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MAIN_MARGIN),
        ])
        
        heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
    }
    
    private func setLabelOn(label: UILabel, withString string: String?) {
        DispatchQueue.main.async {
            label.text = string
        }
    }
}

extension PickedHeroView: PickedHeroViewConfig {
    func pickedHeroView(pickedHero: MDotaHero) {
        self.aPickedHero = pickedHero
    }
    
    var pickedHero: MDotaHero {
        return self.aPickedHero
    }
}
