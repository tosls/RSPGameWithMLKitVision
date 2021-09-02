//
//  GameState.swift
//  RSPGameWithMLKitVision
//
//  Created by Антон Бобрышев on 01.09.2021.
//

import Foundation

enum GameState {
    
    case start, win, lose, draw
    
}

enum Sign {
    
    case rock, papper, scissors
    
    var emojiSign: String {
        switch self {
        case .papper:
            return "📄"
        case .rock:
            return "🪨"
        case .scissors:
            return "✂️"
            
        }
    }
}
