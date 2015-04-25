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
    Undefined,
    Red,
    Black
    func description() -> String {
        switch self {
        case Undefined:
            return "Undefined"
        case Red:
            return "Red"
        case Black:
            return "Black"
        }
    }
}

class GamePiece: Printable {
    var type: GamePieceType

    init(type: GamePieceType){
        self.type = type
    }

    var description: String {
        return "type:" + type.description()
    }
}