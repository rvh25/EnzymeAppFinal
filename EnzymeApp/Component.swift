//
//  Enzyme.swift
//  EnzymeApp
//
//  Created by admin on 2/22/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

import SpriteKit

enum ComponentType: Int, CustomStringConvertible{
    
    //case Unknown = 0, Activator, Competitive_Inhibitor, Deactivator, Enzyme, Noncompetitive_Inhibitor, Substrate

    
    /*case Unknown = 0, Activator, Competitive_Inhibitor, Deactivator, Enzyme, Noncompetitive_Inhibitor, Substrate, Enzyme_with_2_activators_and_substrate, Enzyme_with_Competitive_Inhibitor, Enzyme_with_deactivator, Enzyme_with_Noncompetitive_Inhibitor_and_substrate, Enzyme_with_Noncompetitive_Inhibitor, Enzyme_with_one_activator_and_substrate, Enzyme_with_one_activator, Enzyme_with_two_activators,  ESComplex,  Product*/
    
    case Unknown = 0,  Enzyme, Substrate,Activator, Competitive_Inhibitor, Deactivator, Noncompetitive_Inhibitor,  Enzyme_with_2_activators_and_substrate, Enzyme_with_Competitive_Inhibitor, Enzyme_with_deactivator, Enzyme_with_Noncompetitive_Inhibitor_and_substrate, Enzyme_with_Noncompetitive_Inhibitor, Enzyme_with_one_activator_and_substrate, Enzyme_with_one_activator, Enzyme_with_two_activators,  ESComplex,  Product
    
/*
    case Unknown = 0, Activator, Competitive_Inhibitor, Deactivator, Enzyme_with_2_activators_and_substrate, Enzyme_with_Competitive_Inhibitor, Enzyme_with_deactivator, Enzyme_with_Noncompetitive_Inhibitor_and_substrate, Enzyme_with_Noncompetitive_Inhibitor, Enzyme_with_one_activator_and_substrate, Enzyme_with_one_activator, Enzyme_with_two_activators, Enzyme, ESComplex, Noncompetitive_Inhibitor, Product, Substrate
*/
    
    var spriteName: String {
        let spriteNames = [
        
            /*"Activator",
            "Competitive_Inhibitor",
            "Deactivator",
            "Enzyme",
            "Noncompetitive_Inhibitor",
            "Substrate",
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
        ]*/
        
        
        "Enzyme",
        "Substrate",
        "Activator",
        "Competitive_Inhibitor",
        "Deactivator",
        "Noncompetitive_Inhibitor",
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
        
        
            /*"Activator",
            "Competitive_Inhibitor",
            "Deactivator",
            "Enzyme",
            "Noncompetitive_Inhibitor",
            "Substrate"
        ]*/

/*
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
        "Enzyme",
        "ESComplex",
        "Noncompetitive_Inhibitor",
        "Product",
        "Substrate"
        ]
*/

        
        return spriteNames[rawValue - 1]
    }
    
    static func random() -> ComponentType {
        return ComponentType(rawValue: Int(arc4random_uniform(2)) + 1)!
        //return ComponentType(rawValue: Int(arc4random_uniform(6)) + 1)!
        //return ComponentType(rawValue: Int(arc4random_uniform(16)) + 1)!
    }
    
    var description: String {
        return spriteName
    }
}

//    var highlightedSpriteName: String {
//        return spriteName + "-Highlighted"
//    }
    


class Component: CustomStringConvertible, Hashable {
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
