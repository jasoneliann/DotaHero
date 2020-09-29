//
//  DotaHeroTests.swift
//  DotaHeroTests
//
//  Created by Jason Elian on 26/09/20.
//  Copyright © 2020 Gua Corp. All rights reserved.
//

import XCTest
@testable import DotaHero

class DotaHeroTests: XCTestCase {

    var heroes: [MDotaHero]!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        heroes = [
            MDotaHero(id: 0, name: "Anti-Mage", url: "", roles: [MDotaHero.Role.carry], type: .melee, attribute: .agi, health: 0, attackMax: 33, movementSpeed: 310, manaPoint: 75),
            MDotaHero(id: 2, name: "Bane", url: "", roles: [MDotaHero.Role.carry], type: .melee, attribute: .int, health: 0, attackMax: 41, movementSpeed: 305, manaPoint: 75),
            MDotaHero(id: 3, name: "BloodSeeker", url: "", roles: [MDotaHero.Role.carry], type: .melee, attribute: .int, health: 0, attackMax: 39, movementSpeed: 300, manaPoint: 75),
            MDotaHero(id: 1, name: "Crystal Maiden", url: "", roles: [MDotaHero.Role.support], type: .ranged, attribute: .int, health: 0, attackMax: 36, movementSpeed: 275, manaPoint: 75),
            MDotaHero(id: 1, name: "Axe", url: "", roles: [MDotaHero.Role.initiator], type: .melee, attribute: .str, health: 0, attackMax: 31, movementSpeed: 310, manaPoint: 75),
        ]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        heroes = nil
        try super.tearDownWithError()
    }

    func test_getThe3MostHeroAgi() {
        let comparedHeroes: [ComparedHero] = heroes.map { ComparedHero(comparedValue: $0.movementSpeed, hero: $0) }
        let resultHero: [String] = ["Anti-Mage", "Axe", "Bane"]
        
        var tempResult: [ComparedHero] = []
        
        for hero in comparedHeroes {
            tempResult = arrangeRanks(ranks: tempResult, withValue: hero)
        }
        
        for element in zip(tempResult, resultHero) {
            XCTAssertEqual(element.0.hero.name, element.1)
        }
        
        debugPrint("result \(tempResult)")
    }
    
    private func arrangeRanks(ranks: [ComparedHero],
                              withValue value: ComparedHero) -> [ComparedHero]
    {
        var result: [ComparedHero] = ranks
        
        guard let lastHero = result.last, lastHero.comparedValue > value.comparedValue else { return result }
        
        result.append(value)
        
        result = sortDescending(ranks: result)
        
        if result.count > 3 {
            let _ = result.popLast()
        }
        
        return result
    }
    
    /*
    func test_getTopMostHeroAgi() {
        // Given
        let comparedHeroes: [ComparedHero] = heroes.map { ComparedHero(comparedValue: $0.movementSpeed, hero: $0) }
        let resultHero: [String] = ["Anti-Mage", "Axe", "Bane"]
        
        // When
        let sorted = sortDescending(ranks: comparedHeroes)
        
        // Then
        for element in zip(sorted, resultHero) {
            XCTAssertEqual(element.0.hero.name, element.1)
        }
    }
    
    func test_getTopMostHeroStr() {
        // Given
        let comparedHeroes: [ComparedHero] = heroes.map { ComparedHero(comparedValue: $0.attackMax, hero: $0) }
        let resultHero: [String] = ["Bane", "Anti-Mage", "Axe"]
        
        // When
        let sorted = sortDescending(ranks: comparedHeroes)
        
        // Then
        for element in zip(sorted, resultHero) {
            XCTAssertEqual(element.0.hero.name, element.1)
        }
    }
    
    func test_getTopMostHeroInt() {
        // Given
        let comparedHeroes: [ComparedHero] = heroes.map { ComparedHero(comparedValue: $0.manaPoint, hero: $0) }
        let resultHero: [String] = ["Anti-Mage", "Axe", "Bane"]
        
        // When
        let sorted = sortDescending(ranks: comparedHeroes)
        
        // Then
        for element in zip(sorted, resultHero) {
            XCTAssertEqual(element.0.hero.name, element.1)
        }
    }
    
    func test_sortItemInt_desc() {
        let items: [Int] = [0, 7, 3, 4, 1, 2]
        let expectedResult: [Int] = [7, 4, 3, 2, 1, 0]
        
        // When
        let newItems: [Int] = sortDescending(ranks: items)
        
        // Then
        XCTAssertEqual(expectedResult, newItems)
    }
    
    private func sortDescending(ranks: [Int]) -> [Int] {
        return ranks.sorted { $0 > $1 }
    }*/
    
    private func sortDescending(ranks: [ComparedHero]) -> [ComparedHero] {
        return ranks.sorted { $0.comparedValue > $1.comparedValue }
    }
}
