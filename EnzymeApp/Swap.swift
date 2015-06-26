//
//  Swap.swift
//  EnzymeApp
//
//  Created by admin on 3/24/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

struct Swap: CustomStringConvertible, Hashable {
    let componentA: Component 
    let componentB: Component
    
    init(componentA: Component, componentB: Component) {
        self.componentA = componentA
        self.componentB = componentB
    }
    
    var description: String {
        return "swap \(componentA) with \(componentB)"
    }
    
    var hashValue: Int {
        return componentA.hashValue ^ componentB.hashValue
    }
}

func ==(lhs: Swap, rhs: Swap) -> Bool {
    return (lhs.componentA == rhs.componentA && lhs.componentB == rhs.componentB) ||
            (lhs.componentB == rhs.componentA && lhs.componentA == rhs.componentB)
}