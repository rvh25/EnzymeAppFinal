//
//  Enzyme.swift
//  EnzymeApp
//
//  Created by admin on 2/22/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

import SpriteKit

enum ComponentType: Int, CustomStringConvertible{
    
    case Unknown = 0, Enzyme, Substrate, Noncompetitive_Inhibitor, Activator, Competitive_Inhibitor, Deactivator, Enzyme_with_2_activators_and_substrate, Enzyme_with_Competitive_Inhibitor, Enzyme_with_deactivator, Enzyme_with_Noncompetitive_Inhibitor_and_substrate, Enzyme_with_Noncompetitive_Inhibitor, Enzyme_with_one_activator_and_substrate, Enzyme_with_one_activator, Enzyme_with_two_activators, ESComplex, Product
    
    // The filename of the corresponding sprite image in the texture atlas is returned
    var spriteName: String {
        let spriteNames = [
        
        "Enzyme",
        "Substrate",
        "Noncompetitive_Inhibitor",
        "Activator",
        "Competitive_Inhibitor",
        "Deactivator",
        "Enzyme_with_2_activators_and_substrate",
        "Enzyme_with_Competitive_Inhibitor",
        "Enzyme_with_deactivator",
        "Enzyme_with_Noncompetitive_Inhibitor_and_substrate",
        "Enzyme_with_Noncompetitive_Inhibitor",
        "Enzyme_with_one_activator_and_substrate",
        "Enzyme_with_one_activator",
        "Enzyme_with_two_activators",
        "ESComplex",
        "Product"
        ]
        
        // RawValue will be substracted by one to have the correct array index
        return spriteNames[rawValue - 1]
    }
    
    // arc4random_uniform(n) will generate a random number between 0 and n - 1, which is then convered to an Int. A 1 is then added to have a number between 1 and n. The resulting number corresponds to the rawValues of the sprites.
    static func random() -> ComponentType {
        return ComponentType(rawValue: Int(arc4random_uniform(2)) + 1)!
    }
    
    var description: String {
        return spriteName
    }
}


class Component: CustomStringConvertible, Hashable {
    // The position of an object in the 2D grid is used as the hashValue property
    var hashValue: Int {
        return row*10 + column
    }
    var description: String {
        return "type:\(componentType) square: (\(column),\(row))"
    }
    var column: Int
    var row: Int
    let componentType: ComponentType
    var sprite: SKSpriteNode?
    
    init(column: Int, row: Int, componentType: ComponentType) {
        self.column = column
        self.row = row
        self.componentType = componentType
    }
}


func ==(lhs: Component, rhs: Component) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}
