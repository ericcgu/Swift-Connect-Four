//
//  GamePiece.swift
//  swiftConnectFour
//
//  Created by Eric Gu on 11/1/14.
//  Copyright (c) 2014 Eric Gu. All rights reserved.
//

import Foundation
import SpriteKit

enum GamePieceType: Int {
    case
    undefined,
    red,
    black
    func description() -> String {
        switch self {
        case .undefined:
            return "Undefined"
        case .red:
            return "Red"
        case .black:
            return "Black"
        }
    }
}

class GamePiece: CustomStringConvertible {
    var type: GamePieceType

    init(type: GamePieceType){
        self.type = type
    }

    var description: String {
        return "type:" + type.description()
    }
}
