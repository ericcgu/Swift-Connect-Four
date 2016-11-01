//
//  Game.swift
//  swiftConnectFour
//
//  Created by Eric Gu on 11/1/14.
//  Copyright (c) 2014 Eric Gu. All rights reserved.
//

import Foundation
import UIKit

let NumColumns = 15
let NumRows = 8

var redTurn = true
var isFinished = false

class Game {
    fileprivate var gameBoard = Array2D<GamePiece>(columns: NumColumns, rows: NumRows)

    func gamePieceOnBoard(_ column: Int, _ row: Int) -> GamePiece? {
        return gameBoard[column, row]
    }

    func findEmptyPositionInColumn(column: Int) -> Int? {
        //check if column is full
        if(gameBoard[column, NumRows-1] != nil) {
            return nil
        }

        //find the first empty row
        for row in 0 ..< NumRows {
            if (gameBoard[column, row]) == nil {
                return row
            }
        }
        return nil
    }

    func gamePieceTypeOnBoard(column: Int, _ row: Int) -> GamePieceType {

        if column < 0 || row < 0 || column > NumColumns - 1 || row > NumRows - 1 {
            return GamePieceType.undefined
        }

        if gamePieceOnBoard(column, row) == nil {
            return GamePieceType.undefined
        } else {
            return gamePieceOnBoard(column, row)!.type
        }
    }

    func isLinearMatch(column: Int, row: Int, stepX: Int, stepY: Int)->Bool {
        let startGamePieceType = gamePieceTypeOnBoard(column: column, row)

        for i in 0 ..< 4 {
            let newX = row + i * stepY
            let newY = column + i * stepX

            if(gamePieceTypeOnBoard(column: newY, newX) == GamePieceType.undefined) {
                return false
            }

            if (startGamePieceType != gamePieceTypeOnBoard(column: newY, newX)) {
                return false
            }
        }

        return true
    }

    func checkWinCondition (_ column: Int, row: Int) {
        let alert = UIAlertView()
        alert.title = "Four In a Row! Game Over!"
        alert.addButton(withTitle: "OK")

        for row in 0..<gameBoard.rows {
            for column in 0..<gameBoard.columns {
                //horizontal
                if(isLinearMatch(column: column, row: row, stepX: 1, stepY: 0)) {
                    isFinished = true
                    alert.show()
                }

                //vertical
                if(isLinearMatch(column: column, row: row, stepX: 0, stepY: 1)) {
                    isFinished = true
                    alert.show()
                }

                //diagonal
                if(isLinearMatch(column: column, row: row, stepX: 1, stepY: 1)) {
                    isFinished = true
                    alert.show()
                }

                //second diagonal
                if(isLinearMatch(column: column, row: row, stepX: 1, stepY: -1)) {
                    isFinished = true
                    alert.show()
                }
            }

        }
    }

    func addGamePieceToBoard(_ column: Int, row: Int) {
        //temporary switch
        if redTurn == true {
            redTurn = false
        } else {
            redTurn = true
        }

        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)

        var newGamePieceType:GamePieceType!
        if redTurn {
            newGamePieceType = GamePieceType.red
        } else {
            newGamePieceType = GamePieceType.black
        }
        
        let newGamePiece = GamePiece(type: newGamePieceType)
        
        gameBoard[column, row] = newGamePiece
    }
}
