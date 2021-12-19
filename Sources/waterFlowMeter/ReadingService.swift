//
//  ReadingService.swift
//
//
//  Created by Roman Trekhlebov on 18.12.2021.
//

import Foundation
import SwiftyGPIO

final class ReadingService: NSObject {
    
    var gpios: [GPIOName : GPIO]!
    var pins: [GPIO] = []
    var debugMode: Bool
    let dispatchQ = DispatchQueue(label: "readingQuae")
    
    init(debugMode: Bool) {
        self.debugMode = debugMode
        super.init()

        setupWith(debugMode)
        print("Pins")
        pins.forEach { pin in
            print(pin.value)
        }
    }
    
    private func setupWith(_ debugMode: Bool = false) {
        guard !debugMode else {
            print("Started with debug mode!")
            return}
        print("Started on real device")
        self.gpios = SwiftyGPIO.GPIOs(for: .RaspberryPiPlusZero)
        guard !self.gpios.isEmpty else {
            fatalError("cant find any pins")
        }
        guard let pin1 = gpios[.P26] else {
            fatalError("cant find pin1")
        }
        setupListnerFroPin(pin1)
        print("pins count \(pins.count)")
    }

    
    
    private func setupListnerFroPin(_ gp: GPIO) {
        gp.direction = .IN
        gp.pull = .up
        gp.bounceTime = 0.5
        pins.append(gp)
    }
}
