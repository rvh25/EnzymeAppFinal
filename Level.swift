//
//  Level.swift
//  EnzymeApp
//
//  Created by admin on 2/23/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

import Foundation

let NumColumns = 40
let NumRows = 30

class Level {
    private var components = Array2D<Component>(columns: NumColumns, rows: NumRows)

    func componentAtColumn(column: Int, row: Int) -> Component? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return components[column, row]
    }

    func shuffle() -> Set<Component> {
        var set: Set <Component>
        repeat {
            set = createInitialComponents()
            detectPossibleSwaps()
        }
        while possibleSwaps.count == 0
        return set
    }

    
    private func createInitialComponents() -> Set<Component> {
        var set = Set<Component>()
    
        // Column 0, row 0 is at the bottom left corner of the array. The function loops through the array and a new component is created then added.
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
            
                // A random component type is chosen. Two components next to each other should not be the same type as there is no reaction then.
                var componentType: ComponentType
                repeat {
                componentType = ComponentType.random()
                }
                while (column >= 1 &&
                        components[column - 1, row]?.componentType == componentType)
                    || (row >= 1 &&
                        components[column, row - 1]?.componentType == componentType)

                let component = Component(column: column, row: row, componentType: componentType)
                components[column, row] = component
            
                set.insert(component)
            }
        }
        return set
    }
    
    //Swaps the positions of the components
    func performSwap(swap: Swap) {
        let columnA = swap.componentA.column
        let rowA = swap.componentA.row
        let columnB = swap.componentB.column
        let rowB = swap.componentB.row
        
        components[columnA, rowA] = swap.componentB
        swap.componentB.column = columnA
        swap.componentB.row = rowA

        components[columnB, rowB] = swap.componentA
        swap.componentA.column = columnB
        swap.componentA.row = rowB
    }
    
    private var possibleSwaps = Set<Swap>()
    
    // Determines if there is a rxn for the two components
    // If the first component is an enzyme and the second component is not an enzyme nor a product then there is a rxn and vice versa.
    private func hasRxn(component1: Component, component2: Component) -> Bool {
        let type = ComponentType.Enzyme
        if (component2.componentType != ComponentType.Product && component1.componentType == type && component2.componentType != type) || (component1.componentType != ComponentType.Product && component1.componentType != type && component2.componentType == type) {
            return true
        }
        return false
    }
    
    // Detects and creates a set of possible swaps
    func detectPossibleSwaps() {
        var set = Set<Swap>()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = components[column, row] {
                    // Last column does not need to be checked
                    if column < NumColumns - 1 {
                        // the component next to it
                        if let other = components[column + 1, row] {
                            // Checks to see if there is a rxn, then adds it to the set
                            if hasRxn(component, component2: other) {
                                set.insert(Swap(componentA: component, componentB: other))
                            }
                        }
                    }
                    
                    // Last row does need to be checked
                    if row < NumRows - 1 {
                        // the component above it
                        if let other = components[column, row + 1] {
                            // Checks to see if there is a rxn, then adds it to the set
                            if hasRxn(component, component2: other) {
                                set.insert(Swap(componentA: component, componentB: other))
                            }
                        }
                    }
                }
            }
        }
        possibleSwaps = set
        print("possible swaps: \(possibleSwaps)")
    }
    
    // Checks if there are zero possible swaps
    func checkswaps() -> Bool {
        if possibleSwaps.isEmpty    {
            return true
        }
        return false
    }
    
    func isPossibleSwap(swap: Swap) -> Bool {
        return possibleSwaps.contains(swap)
    }
    
    // Returns an array with enzymes based on their original positions
    func components(component1:Component, component2: Component) -> [[Component]]{
        var columns = [[Component]]()
        var array = [Component]()
        if component1.componentType == ComponentType.Enzyme {
            let component = Component(column: component2.column, row: component2.row, componentType: component1.componentType)
            components[component.column, component.row] = component
            array.append(component)
        }
        
        if !array.isEmpty {
            columns.append(array)
        }
        return columns
    }
    
    // Sets the components to nil
    func removepieces(component1: Component, component2: Component) {
        components[component1.column, component1.row] = nil
        components[component2.column, component2.row] = nil
    }
    
    private var substrates = Set<Component>()

    // Set of substrates
    func substrateComponents() {
        var set = Set<Component>()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = components[column, row] {
                    if component.componentType == ComponentType.Substrate {
                        set.insert(component)
                    }
                }
            }
        }
        substrates = set
        print("substrates: \(substrates)")
    }
    
    private var others = Set<Component>()
    
    // Set of components: Substrates, Inhibitors, Activators, and Deactivators
    func otherComponents() {
        var set = Set<Component>()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = components[column, row] {
                    if component.componentType != ComponentType.Enzyme && component.componentType != ComponentType.Product {
                        set.insert(component)
                    }
                }
            }
        }
        others = set
        print("other: \(others)")
    }
    
}