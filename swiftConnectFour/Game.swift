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
    
    private var gameBoard = Array2D<GamePiece>(columns: NumColumns, rows: NumRows)
    
    func gamePieceOnBoard(#column: Int, row: Int) -> GamePiece? {
        return gameBoard[column, row]
    }
    
    func findEmptyPositionInColumn(#column: Int) -> Int? {
        //check if column is full
        if(gameBoard[column, NumRows-1] != nil){
            return nil
        }
        
        //find the first empty row
        for var row = 0; row < NumRows; ++row{
            if (gameBoard[column, row]) == nil {
                return row
            }
        }
        return nil
    }
    
    func gamePieceTypeOnBoard(#column: Int, row: Int) -> GamePieceType{
        
        if column < 0 || row < 0 || column > NumColumns - 1 || row > NumRows - 1 {
            return GamePieceType.Undefined
        }
        
        
        if gamePieceOnBoard(column: column, row: row) == nil{
            return GamePieceType.Undefined
        }
        else{
            return gamePieceOnBoard(column: column, row: row)!.type
        }
    
    }
    
    func isLinearMatch(#column: Int, row: Int, stepX: Int, stepY: Int)->Bool{
        var startGamePieceType = gamePieceTypeOnBoard(column: column, row: row)
        
            for var i = 0; i < 4; ++i{
            var newX = row + i * stepY
            var newY = column + i * stepX
                
            if(gamePieceTypeOnBoard(column: newY, row: newX) == GamePieceType.Undefined){
                    return false
                }
            
            if (startGamePieceType != gamePieceTypeOnBoard(column: newY, row: newX)){
                return false
                }

        }
        
        return true

    }
    
    func checkWinCondition (column: Int, row: Int){
        let alert = UIAlertView()
        alert.title = "Four In a Row! Game Over!"
        alert.addButtonWithTitle("OK")
        
        for row in 0..<gameBoard.rows {
            for column in 0..<gameBoard.columns {
                
                //horizontal
                if(isLinearMatch(column: column, row: row, stepX: 1, stepY: 0)){
                    isFinished = true
                    alert.show()
                }
                
                //vertical
                if(isLinearMatch(column: column, row: row, stepX: 0, stepY: 1)){
                    isFinished = true
                    alert.show()
                }
                
                //diagonal
                if(isLinearMatch(column: column, row: row, stepX: 1, stepY: 1)){
                    isFinished = true
                    alert.show()
                }
                
                //second diagonal
                if(isLinearMatch(column: column, row: row, stepX: 1, stepY: -1)){
                    isFinished = true
                    alert.show()
                }
            }
        
        }
        
        
        
        
    }
    
    func addGamePieceToBoard(column: Int, row: Int){
        //temporary switch
        if redTurn == true{
            redTurn = false
        }
        else{
            redTurn = true
        }
        
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        
        var newGamePieceType:GamePieceType!
        if redTurn{
            newGamePieceType = GamePieceType.Red
        }
        else{
            newGamePieceType = GamePieceType.Black
        }
        
        let newGamePiece = GamePiece(type: newGamePieceType)
        
        gameBoard[column, row] = newGamePiece
        
        
    }
}
