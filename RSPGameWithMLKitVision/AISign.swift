//
//  AISign.swift
//  RSPGameWithMLKitVision
//
//  Created by Антон Бобрышев on 02.09.2021.
//

import Foundation
import GameplayKit

class AISign {
    
    static let shared = AISign()
    
    private init() {}

    let randomChoice = GKRandomDistribution(lowestValue: 0, highestValue: 2)

    func aiRandomChoice() -> Sign {
    
        let choice = randomChoice.nextInt()
        var aiSign: Sign {
            switch choice {
            case 0:
                return .rock
            case 1:
                return .papper
            default:
                return .scissors
            }
        }
        return aiSign
    }
}
