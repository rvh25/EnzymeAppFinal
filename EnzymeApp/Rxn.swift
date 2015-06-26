//
//  Rxn.swift
//  EnzymeApp
//
//  Created by admin on 5/5/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

class Rxn: Hashable, CustomStringConvertible {
    var components = [Component]()
    
    enum RxnType: CustomStringConvertible {
        case Horizontal
        case Vertical
        
        var description: String {
            switch self {
            case .Horizontal: return "Horizontal"
            case .Vertical: return "Vertical"
            }
        }
    }
    
    var rxnType: RxnType
    
    init(rxnType: RxnType) {
        self.rxnType = rxnType
}

    func addComponent(component: Component) {
        components.append(component)
    }
    
    func firstComponent() -> Component {
        return components[0]
    }
    
    func lastComponent() -> Component {
        return components[components.count - 1]
    }
    
    var length: Int {
        return components.count
    }
    
    var description: String {
        return "type:\(rxnType) components:\(components)"
    }
    
    var hashValue: Int {
        return components.reduce(0) { $0.hashValue ^ $1.hashValue }
    }
}

func ==(lhs: Rxn, rhs: Rxn) -> Bool {
    return lhs.components == rhs.components
}
