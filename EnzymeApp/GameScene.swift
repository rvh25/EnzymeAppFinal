//
//  GameScene.swift
//  EnzymeApp
//
//  Created by admin on 2/22/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
}
    
    override init(size: CGSize) {
        super.init(size: size)

        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        addChild(gameLayer)
        
        let layerPosition = CGPoint(
            x: -TileWidth*CGFloat(NumColumns)/2,
            y: -TileHeight*CGFloat(NumRows)/2)
        
        componentsLayer.position = layerPosition
        gameLayer.addChild(componentsLayer)
        
        swipeFromColumn = nil
        swipeFromRow = nil
        
    }

    // When the user first touches the screen, the react function then runs
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.react()
    }
    
    // React initiates the process of swapping the components
    func react() {
        //First calls direction which determines a possible direction for enzyme components to swap to
        self.direction()
        
        // After completing swaps, and components are reverted back, detectPossibleSwaps then lists if there are any possible swaps left
        level.detectPossibleSwaps()
        
        // Checkswaps from Level then determines if there are zero swaps
        // If checkswaps is true, the function exits
        if level.checkswaps() {
           /* if othertype() {
                level.otherComponents()
            }
            
            else {
                return
            }*/
            return
        }
        
        // If checkswaps is false, then the system repeats until there are no remaining swaps
            else {
            self.react()
        }
    }

    // Checks for substrates
    func subs() -> Bool {
        let type = ComponentType.Substrate
        
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = level.componentAtColumn(column, row: row){
                    if component.componentType == type {
                        return true
                    }
                }
            }
        }
        return false
    }

    //Checks for components: Substrate, Competitive Inhibitor, Noncompetitive Inhibitor, Deactivator, and Activator
    func othertype() -> Bool {
        let type = ComponentType.Enzyme
        let type2 = ComponentType.Product

        
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = level.componentAtColumn(column, row: row){
                    if component.componentType != type && component.componentType != type2 {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    // For each enzyme component, randomly decides a direction to react with another component, above, below, or next to it
    func direction() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let component = level.componentAtColumn(column, row: row) {
                        if component.componentType == ComponentType.Enzyme  {

                        print("component: \(component.componentType, component.column, component.row)")
                        
                        swipeFromColumn = component.column
                        swipeFromRow = component.row

                
                        var horzDelta = 0, vertDelta = 0
                        if row == 0 && column == 0 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = 1
                            }
                            else if dataConverter == 2 {
                                vertDelta = 1
                            }
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            trySwap(horzDelta, vertical: vertDelta)
                        }
                            
                        else if row == NumRows - 1 && column == NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            trySwap(horzDelta, vertical: vertDelta)
                        }
                            
                        else if row == 0 && column == NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                vertDelta = 1
                            }
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            trySwap(horzDelta, vertical: vertDelta)
                        }
                            
                        else if row == NumRows - 1 && column == 0 {
                            let dataConverter = Int(arc4random_uniform(2)+1)
                            if dataConverter == 1 {
                                horzDelta = 1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            trySwap(horzDelta, vertical: vertDelta)
                        }
                            
                        else if row == 0 && column != 0 && column != NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                horzDelta = 1
                            }
                            else if dataConverter == 3 {
                                vertDelta = 1
                            }
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            trySwap(horzDelta, vertical: vertDelta)
                        }
                            
                        else if row == NumRows - 1 && column != 0 && column != NumColumns - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                horzDelta = 1
                            }
                            else if dataConverter == 3 {
                                vertDelta = -1
                            }
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            trySwap(horzDelta, vertical: vertDelta)
                        }
                            
                        else if column == 0 && row != 0 && row != NumRows - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = 1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            else if dataConverter == 3 {
                                vertDelta = 1
                            }
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            trySwap(horzDelta, vertical: vertDelta)
                        }
                            
                        else if column == NumColumns - 1 && row != 0 && row != NumRows - 1 {
                            let dataConverter = Int(arc4random_uniform(3)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                vertDelta = -1
                            }
                            else if dataConverter == 3 {
                                vertDelta = 1
                            }
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            trySwap(horzDelta, vertical: vertDelta)
                        }
                            
                        else {
                            let dataConverter = Int(arc4random_uniform(4)+1)
                            if dataConverter == 1 {
                                horzDelta = -1
                            }
                            else if dataConverter == 2 {
                                horzDelta = 1
                            }
                            else if dataConverter == 3 {
                                vertDelta = -1
                            }
                            else if dataConverter == 4 {
                                vertDelta = 1
                            }
                            print("dataConverter: \(dataConverter)")
                            print("horzDelta, vertDelta: \(horzDelta, vertDelta)")
                            trySwap(horzDelta, vertical: vertDelta)
                        }
                    }
                }
            }
        }
    }
    
    /*override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swipeFromColumn = nil
        swipeFromRow = nil
    }

    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        touchesEnded(touches!, withEvent: event)
    }*/

    var swipeHandler: ((Swap) -> ())?
    
    var swipeFromColumn: Int?
    var swipeFromRow: Int?
    
    var level: Level!
    
    let TileWidth: CGFloat = 25
    let TileHeight: CGFloat = 25
    
    let gameLayer = SKNode()
    let componentsLayer = SKNode()
    
    // A new sprite is created for each component and then added to the componentsLayer
    func addSpritesForComponents(components: Set<Component>) {
        for component in components {
            let sprite = SKSpriteNode(imageNamed: component.componentType.spriteName)
            sprite.position = pointForColumn(component.column, row:component.row)
            componentsLayer.addChild(sprite)
            component.sprite = sprite
        }
    }
    
    // CGPoints x and y are CGFloat types, while NumColumns and NumRows are Int types. Each column and row Int value will be converted to a CGPoint relative to the componentsLayer
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*TileWidth + TileWidth/2,
            y: CGFloat(row)*TileHeight + TileHeight/2)
    }
    
    // Opposite of pointForColumn, where a CGPoint relative to the componentsLayer is converted into column and row Int values. The boolean indicates success or failure. Failure is returned if the location is invalid in the componentsLayer.
    func convertPoint(point: CGPoint) -> (success: Bool, column: Int, row: Int) {
        if point.x >= 0 && point.x < CGFloat(NumColumns)*TileWidth &&
            point.y >= 0 && point.y < CGFloat(NumRows)*TileHeight {
                return (true, Int(point.x/TileWidth), Int(point.y/TileHeight))
        } else {
            return (false, 0, 0)
        }
    }
    
    // Determines if the swap is possible. If the swap is possible then the swap is performed.
    func trySwap(horzDelta: Int, vertical vertDelta: Int) {
        let toColumn = swipeFromColumn! + horzDelta
        let toRow = swipeFromRow! + vertDelta
        
        if let toComponent = level.componentAtColumn(toColumn, row: toRow) {
            if let fromComponent = level.componentAtColumn(swipeFromColumn!, row: swipeFromRow!) {
                
                // If fromComponent is an enzyme and toComponent is not an enzyme then the swap is possible
                if fromComponent.componentType == ComponentType.Enzyme && toComponent.componentType != ComponentType.Enzyme{
                    
                    print("fromComponent: \(fromComponent.componentType, fromComponent.column, fromComponent.row )")
                    print("toComponent: \(toComponent.componentType, toComponent.column, toComponent.row)")
                    
                    if let handler = swipeHandler {
                        let swap = Swap(componentA: fromComponent, componentB: toComponent)
                        handler(swap)
                        
                        print("afterswapfromComponent: \(fromComponent.componentType, fromComponent.column, fromComponent.row )")
                        print("afterswaptoComponent: \(toComponent.componentType, toComponent.column, toComponent.row)")

                        // Removepieces defines the sprites as nil.
                        // Removecomponents removes the sprites.
                        // Combinedcomponent defines the sprite of a new component, either enzyme substrate complex, enzyme with an inhibitor, enzyme with an activator, or enzyme with a deactivator
                        level.removepieces(fromComponent, component2: toComponent)
                        self.removecomponents(fromComponent, component2: toComponent)
                        self.combinedcomponent(fromComponent, component2: toComponent)

                    }
                }
            }
        }
    }

    // Animates the sprites swapping
    func animateSwap(swap: Swap, completion: () -> ()) {
        //  let spriteA = swap.componentA.sprite!
        if let spriteA = swap.componentA.sprite {
            
            let spriteB = swap.componentB.sprite!
            
            
            spriteA.zPosition = 90
            spriteB.zPosition = 100
            
            let Duration: NSTimeInterval = 1.5
            
            let moveA = SKAction.moveTo(spriteB.position, duration: Duration)
            moveA.timingMode = .EaseOut
            spriteA.runAction(moveA, completion: completion)
            
            let moveB = SKAction.moveTo(spriteA.position, duration: Duration)
            moveB.timingMode = .EaseOut
            spriteB.runAction(moveB)
        }
    }
    
    // Removes sprites
    func removecomponents(component1: Component, component2: Component) {
        if component1.componentType == ComponentType.Enzyme {
            if let sprite1 = component1.sprite {
                if sprite1.actionForKey("removing") == nil {
                    let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                    scaleAction.timingMode = .EaseOut
                    sprite1.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                        withKey:"removing")
                }
            }
            
            if let sprite2 = component2.sprite {
                if sprite2.actionForKey("removing") == nil {
                    let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
                    scaleAction.timingMode = .EaseOut
                    sprite2.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                        withKey:"removing")
                }
            }
        }
    }
    
    // Defines the intermediate
    // For noncompetitive inhibitor and activator cases, other functions are called to determine if the sprites can be reacted again into enzyme with noncompetitive inhibitor and substrate, enzyme with an activator and substrate, enzyme with two activators, or enzymes with two activators and substrate
    func combinedcomponent(component1: Component, component2: Component) {
        if component1.componentType == ComponentType.Enzyme {
            if component2.componentType == ComponentType.Substrate {
                // Enzyme substrate complex
                combinedpiece(component1, newcomponentType: ComponentType.ESComplex, appear: 2, disappear: 4)
                // Revert to enzyme and product components
                revertcomponents(component1, component2: component2)
            }
            
            if component2.componentType == ComponentType.Competitive_Inhibitor {
                // Enzyme with competitive inhibitor
                combinedpiece(component1, newcomponentType: ComponentType.Enzyme_with_Competitive_Inhibitor, appear: 2, disappear: 4)
                // Revert back to enzyme and competitive inhibitor components
                revertcomponents(component1, component2: component2)
            }
            
            if component2.componentType == ComponentType.Deactivator {
                // Enzyme with deactivator
                combinedpiece(component1, newcomponentType: ComponentType.Enzyme_with_deactivator, appear: 2, disappear: 4)
                // Revert back to enzyme and deactivator components
                revertcomponents(component1, component2: component2)
            }
            
            if component2.componentType == ComponentType.Noncompetitive_Inhibitor {
                // Enzyme with noncompetitive inhibitor
                noncompetitiveinhibitor(component1, component2: component2)
            }
            
            if component2.componentType == ComponentType.Activator {
                // Enzyme with one activator
                activator(component1, component2: component2)
            }
        }
    }
    
    // Creates sprite for the intermediate
    // The sprite's position is defined by the input component's position and the componentType is the input component's componentType. 
    // The combinedcomponent sprite should appear and be removed after a specified time
    func combinedpiece(component: Component, newcomponentType: ComponentType, appear: NSTimeInterval, disappear: NSTimeInterval) {
        
        let newcomponent = Component(column: component.column, row: component.row, componentType: newcomponentType)
        
        let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
        sprite.position = pointForColumn(component.column, row: component.row)
        componentsLayer.addChild(sprite)
        newcomponent.sprite = sprite
        
        let newPosition = pointForColumn(component.column, row: component.row)
        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
        moveAction.timingMode = .EaseOut
        sprite.alpha = 0
        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(appear), SKAction.fadeInWithDuration(0.25), moveAction]))
        
        let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(disappear), scaleAction, SKAction.removeFromParent()]),
            
            withKey:"removing")
    }
    
    // level.components creates an array of the enzyme locations and then components are reverted back to the starting positions
    func revertcomponents(component1: Component, component2: Component) {
        level.components(component1, component2: component2)
        revert(component1, component2: component2)
    }
    
    // Uses components function to create sprites based on the original component1 and component2
    func revert(component1: Component, component2: Component) {
        if component1.componentType == ComponentType.Enzyme {
            if component2.componentType == ComponentType.Substrate {
                //Enzyme and Product
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Product)
            }
            
            if component2.componentType == ComponentType.Competitive_Inhibitor{
                //Enzyme and Competitive Inhibitor
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Competitive_Inhibitor)
            }
            
            if component2.componentType == ComponentType.Deactivator {
                //Enzyme and Deactivator
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Deactivator)
            }
            
            if component2.componentType == ComponentType.Noncompetitive_Inhibitor {
                //Enzyme and Noncompetitive Inhibitor
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Noncompetitive_Inhibitor)
            }
            
            if component2.componentType == ComponentType.Activator {
                //Enzyme and Activator
                components(component1, component2: component2, componentType: ComponentType.Enzyme, newcomponentType: ComponentType.Activator)
            }
        }
    }
    
    // Uses componentsprite to create a sprite at position component2 of componentType and a sprite at position component1 of the newcomponentType
    func components(component1: Component, component2: Component, componentType: ComponentType, newcomponentType: ComponentType) {
        
        componentsprite(component2, componentType: componentType)
        componentsprite(component1, componentType: newcomponentType)
        
    }

    // Creates sprite for defined component and type
    func componentsprite(component: Component, componentType: ComponentType) {
        let newcomponent = Component(column: component.column, row: component.row, componentType: componentType)
        let sprite = SKSpriteNode(imageNamed: newcomponent.componentType.spriteName)
        sprite.position = pointForColumn(component.column, row: component.row)
        componentsLayer.addChild(sprite)
        component.sprite = sprite
        
        let newPosition = pointForColumn(component.column, row: component.row)
        let moveAction = SKAction.moveTo(newPosition, duration: 0.3)
        moveAction.timingMode = .EaseOut
        sprite.alpha = 0
        sprite.runAction(SKAction.sequence([SKAction.waitForDuration(10), SKAction.group([SKAction.fadeInWithDuration(0.25), moveAction])]))
    }
    
    // Noncompetitive Inhibitor Case
    func noncompetitiveinhibitor(component1: Component, component2: Component) {
        // Creates the sprite for an enzyme with a noncompetitive inhibitor, then removes the sprite after a specified time
        combinedpiece(component1, newcomponentType: ComponentType.Enzyme_with_Noncompetitive_Inhibitor, appear: 1, disappear: 3)

        let newcomponent = Component(column: component1.column, row: component1.row, componentType: ComponentType.Enzyme_with_Noncompetitive_Inhibitor)

        // If there are substrates then the function proceeds to the ncis function to check for nearby substrates
        if subs() {
            ncis(component1, component2: component2, newcomponent: newcomponent)
        }
        
        // If there are no substrates, only enzymes and noncompetitive inhibitors, the function proceeds to revert back to enzyme and noncompetitive inhibitor components
        else {
            revertcomponents(component1, component2: component2)
        }
    }
    
    // Based on the component's location, randomly decides a direction to check the component next to it, above it, or below it.
    // Checkforsubstrate then checks whether or not that component is a substrate.
    func ncis(component1: Component, component2: Component, newcomponent: Component) {
        var horzDelta = 0, vertDelta = 0
        
        if newcomponent.row == 0 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            checkforsubstrate(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            checkforsubstrate(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == 0 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            checkforsubstrate(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            checkforsubstrate(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == 0 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            checkforsubstrate(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            checkforsubstrate(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.column == 0 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            checkforsubstrate(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.column == NumColumns - 1 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            checkforsubstrate(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else {
            let dataConverter = Int(arc4random_uniform(4)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            else if dataConverter == 4 {
                vertDelta = 1
            }
            checkforsubstrate(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
    }
    
    // Determines if othercomponent is a substrate or not
    func checkforsubstrate(component1: Component, component2: Component, newcomponent: Component, horzDelta: Int, vertDelta: Int) {
        if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
            // If othercomponent is a substrate, proceed to nci
            if othercomponent.componentType == ComponentType.Substrate {
                nci(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent)
            }
            // If othercomponent is not a substrate, revert back to components enzyme and noncompetitive inhibitor
            else {
                 revertcomponents(component1, component2: component2)
            }
        }
        
        // If othercomponent is nil, revert back to components enzyme and noncompetitive inhibitor
        else {
            revertcomponents(component1, component2: component2)
        }
    }
    
    // Creates the sprite for enzyme with noncompetitive inhibitor and substrate and then reverts back
    func nci(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component) {
        // The substrate sprite is removed
        remove(othercomponent)
        
        // A new sprite is created for an enzyme with noncompetitive inhibitor and substrate, then removed after a specified time
        combinedpiece(othercomponent, newcomponentType: ComponentType.Enzyme_with_Noncompetitive_Inhibitor_and_substrate, appear: 4, disappear: 6)

        //Reverts to the original components, enzyme, noncompetitive inhibitor, and substrate
        level.components(component1, component2: component2)
        componentsprite(component2, componentType: ComponentType.Enzyme)
        componentsprite(component1, componentType: ComponentType.Noncompetitive_Inhibitor)
        componentsprite(othercomponent, componentType: ComponentType.Substrate)
        
    }
    
    // Removes sprite
    func remove(component:Component) {
        if let sprite = component.sprite {
            let scaleAction = SKAction.scaleTo(0.1, duration: 0.3)
            scaleAction.timingMode = .EaseOut
            sprite.runAction(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                withKey:"removing")
        }
    }
    
    // Activator Case
    func activator(component1: Component, component2: Component) {
        // Creates the sprite for an enzyme with a single activator, then removes the sprite after a specified time
        combinedpiece(component2, newcomponentType: ComponentType.Enzyme_with_one_activator, appear: 1, disappear: 3)
        
        let newcomponent = Component(column: component2.column, row: component2.row, componentType: ComponentType.Enzyme_with_one_activator)
        
        // If there are substrates, proceed to the asa function to check for nearby substrates
        if subs() {
            asa(component1, component2: component2, newcomponent: newcomponent)
        }
        // If there are no substrates, only enzymes and activators, revert back to enzyme and activator components
        else {
            revertcomponents(component1, component2: component2)
        }
    }
    
    // Based on the component's location, randomly decides a direction to check the component next to it, above it, or below it.
    // Substrateoractivator then checks if the component is either a substrate, activator, or neither.
    func asa(component1: Component, component2: Component, newcomponent: Component) {
        var horzDelta = 0, vertDelta = 0
        
        if newcomponent.row == 0 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            substrateoractivator(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            substrateoractivator(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == 0 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            substrateoractivator(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            substrateoractivator(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == 0 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            substrateoractivator(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            substrateoractivator(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.column == 0 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            substrateoractivator(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.column == NumColumns - 1 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            substrateoractivator(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else {
            let dataConverter = Int(arc4random_uniform(4)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            else if dataConverter == 4 {
                vertDelta = 1
            }
            substrateoractivator(component1, component2: component2, newcomponent: newcomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
    }
    
    // Determines if othercomponent is a substrate, activator or neither
    func substrateoractivator(component1: Component, component2: Component, newcomponent: Component, horzDelta: Int, vertDelta: Int) {
        if let othercomponent = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
            if othercomponent.componentType == ComponentType.Substrate {
                // If othercomponent is a substrate then it is removed
                remove(othercomponent)
                
                // A new sprite is created for an enzyme with one activator and a substrate, then removed after a specified time
                combinedpiece(newcomponent, newcomponentType: ComponentType.Enzyme_with_one_activator_and_substrate, appear: 4, disappear: 6)
                
                let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_one_activator_and_substrate)
                
                // The function then proceeds to activatorcheck that determines if a nearby component is an activator
                activatorcheck(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
            }
                
            else if othercomponent.componentType == ComponentType.Activator {
                // If other component is an activator then it is removed
                remove(othercomponent)
                
                // A new sprite is created for an enzyme with two activators, then removed after a specified time
                combinedpiece(newcomponent, newcomponentType: ComponentType.Enzyme_with_two_activators, appear: 4, disappear: 6)
                
                let newcomponent2 = Component(column: newcomponent.column, row: newcomponent.row, componentType: ComponentType.Enzyme_with_two_activators)
                
                // The function then proceeds to substratecheck that determines if a nearby component is a substrate
                substratecheck(component1, component2: component2, newcomponent: newcomponent2, othercomponent: othercomponent)
            }
            
            // If othercomponent is neither a substrate nor an activator then the function proceeds to revert back to the original components of an enzyme and an activator
            else {
                revertcomponents(component1, component2: component2)
            }
        }
        
        //If othercomponent is nil, revert back to the original components of an enzyme and an activator
        else {
            revertcomponents(component1, component2: component2)
        }
    }

    // Activatorcheck randomly decides a direction to check the component next to it, above it, or below it. The direction is then used as the input for activatorcase
    func activatorcheck(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component) {
        
        var horzDelta = 0, vertDelta = 0
        
        if newcomponent.row == 0 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            activatorcase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            activatorcase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == 0 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            activatorcase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            activatorcase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == 0 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            activatorcase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            activatorcase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.column == 0 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            activatorcase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.column == NumColumns - 1 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            activatorcase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else {
            let dataConverter = Int(arc4random_uniform(4)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            else if dataConverter == 4 {
                vertDelta = 1
            }
            activatorcase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
    }

    // Determines if othercomponent2 is an activator or not
    func activatorcase(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component, horzDelta: Int, vertDelta: Int) {
        if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
            if othercomponent2.componentType == ComponentType.Activator {
                // If othercomponent2 is an activator then the function then proceeds to easa
                easa(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
            }
            
            // If othercomponent2 is not an activator then the function proceeds to revert back to components enzyme, activator, and substrate
            else {
                level.components(component1, component2: component2)
                componentsprite(component2, componentType: ComponentType.Enzyme)
                componentsprite(component1, componentType: ComponentType.Activator)
                componentsprite(othercomponent, componentType: ComponentType.Substrate)
            }
        }
        
        // If othercomponent2 is nil then the function proceeds to revert back to components enzyme, activator, and substrate
        else {
            level.components(component1, component2: component2)
            componentsprite(component2, componentType: ComponentType.Enzyme)
            componentsprite(component1, componentType: ComponentType.Activator)
            componentsprite(othercomponent, componentType: ComponentType.Substrate)
        }
    }
    
    // Creates the sprite for enzyme with two activators and substrate and then reverts back
    func easa(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component, othercomponent2: Component) {
        // The activator sprite is removed
        remove(othercomponent2)
        
        // A new sprite is created for an enzyme with two activators and a substrate, then removed after a specified time
        combinedpiece(newcomponent, newcomponentType: ComponentType.Enzyme_with_2_activators_and_substrate, appear: 7, disappear: 9)
        
        // The function then reverts to the original components, enzyme, activator, substrate, and activator
        level.components(component1, component2: component2)
        componentsprite(component2, componentType: ComponentType.Enzyme)
        componentsprite(component1, componentType: ComponentType.Activator)
        componentsprite(othercomponent, componentType: ComponentType.Substrate)
        componentsprite(othercomponent2, componentType: ComponentType.Activator)
    }
    
    // Substratecheck randomly decides a direction to check the component next to it, above it, or below it. The direction is then used as the input for substratecase
    func substratecheck(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component) {
        var horzDelta = 0, vertDelta = 0
        
        if newcomponent.row == 0 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            substratecase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            substratecase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == 0 && newcomponent.column == NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = 1
            }
            substratecase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column == 0 {
            let dataConverter = Int(arc4random_uniform(2)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
           substratecase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == 0 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            substratecase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.row == NumRows - 1 && newcomponent.column != 0 && newcomponent.column != NumColumns - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            substratecase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.column == 0 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = 1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            substratecase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else if newcomponent.column == NumColumns - 1 && newcomponent.row != 0 && newcomponent.row != NumRows - 1 {
            let dataConverter = Int(arc4random_uniform(3)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                vertDelta = -1
            }
            else if dataConverter == 3 {
                vertDelta = 1
            }
            substratecase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
            
        else {
            let dataConverter = Int(arc4random_uniform(4)+1)
            if dataConverter == 1 {
                horzDelta = -1
            }
            else if dataConverter == 2 {
                horzDelta = 1
            }
            else if dataConverter == 3 {
                vertDelta = -1
            }
            else if dataConverter == 4 {
                vertDelta = 1
            }
            substratecase(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, horzDelta: horzDelta, vertDelta: vertDelta)
        }
    }
    
    // If othercomponent2 is not an substrate then the function proceeds to revert back to components enzyme, activator, and activator
    func substratecase(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component, horzDelta: Int, vertDelta: Int) {
        if let othercomponent2 = level.componentAtColumn(newcomponent.column + horzDelta, row: newcomponent.row + vertDelta) {
            if othercomponent2.componentType == ComponentType.Substrate {
                // If othercomponent2 is a substrate then the function then proceeds to e2as
                e2as(component1, component2: component2, newcomponent: newcomponent, othercomponent: othercomponent, othercomponent2: othercomponent2 )
            }
            // If othercomponent2 is not an substrate then the function proceeds to revert back to components enzyme, activator, and activator
            else {
                level.components(component1, component2: component2)
                componentsprite(component2, componentType: ComponentType.Enzyme)
                componentsprite(component1, componentType: ComponentType.Activator)
                componentsprite(othercomponent, componentType: ComponentType.Activator)
            }
        }
        
        // If othercomponent2 is nil then the function proceeds to revert back to components enzyme, activator, and activator
        else {
            level.components(component1, component2: component2)
            componentsprite(component2, componentType: ComponentType.Enzyme)
            componentsprite(component1, componentType: ComponentType.Activator)
            componentsprite(othercomponent, componentType: ComponentType.Activator)
        }
    }
    
    // Creates the sprite for enzyme with two activators and substrate and then reverts back
    func e2as(component1: Component, component2: Component, newcomponent: Component, othercomponent: Component, othercomponent2: Component)  {
        // The substrate sprite is removed
        remove(othercomponent2)
        
        // A new sprite is created for an enzyme with two activators and a substrate, then removed after a specified time
        combinedpiece(newcomponent, newcomponentType: ComponentType.Enzyme_with_2_activators_and_substrate, appear: 7, disappear: 9)
        
        // The function then reverts to the original components, enzyme, activator, activator, and substrate
        level.components(component1, component2: component2)
        componentsprite(component2, componentType: ComponentType.Enzyme)
        componentsprite(component1, componentType: ComponentType.Activator)
        componentsprite(othercomponent, componentType: ComponentType.Activator)
        componentsprite(othercomponent2, componentType: ComponentType.Substrate)
    }
}




