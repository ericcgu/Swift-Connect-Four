//
//  GameScene.swift
//  swiftConnectFour
//
//  Created by Eric Gu on 10/31/14.
//  Copyright (c) 2014 Eric Gu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var game: Game!

    let TileWidth: CGFloat = 32.0
    let TileHeight: CGFloat = 36.0

    let boardLayer = SKNode()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }

    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let background = SKSpriteNode(imageNamed: "background")
        background.yScale = 2.0
        background.xScale = 2.0
        addChild(background)

        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(NumColumns) / 2,
            y: -TileHeight * CGFloat(NumRows) / 2)
        let tilesLayer = SKNode()
        boardLayer.position = layerPosition
        addChild(boardLayer)
    }

    func addTiles() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                let tileNode = SKSpriteNode(imageNamed: "Tile")
                tileNode.position = pointForColumn(column, row: row)
                boardLayer.addChild(tileNode)
            }
        }
    }

    func addSpriteForGamePiece(column: Int, _ row: Int, type: GamePieceType) {
        let addedGamePiece = GamePiece(type: type)

        var pieceNode = SKSpriteNode(imageNamed: "Red")
        if (type == GamePieceType.black){
            pieceNode = SKSpriteNode(imageNamed: "Black")
        }

        pieceNode.position = pointForColumn(column, row:NumRows)

        boardLayer.addChild(pieceNode)
        //animation
        let actualDuration = CGFloat(2.0)
        // Create the actions
        let actionMove = SKAction.move(to: pointForColumn(column, row: row), duration: TimeInterval(actualDuration))

        pieceNode.run(SKAction.sequence([actionMove]))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: boardLayer)
        let (success, column, row) = convertPoint(location!)
        if success {
            if isFinished {
                return
            }
            if let emptyRow = game.findEmptyPositionInColumn(column: column){

                game.addGamePieceToBoard(column, row: emptyRow)
                if(game.gamePieceOnBoard(column, emptyRow)!.type == GamePieceType.red) {
                    addSpriteForGamePiece(column: column, emptyRow, type: GamePieceType.red)
                } else {
                    addSpriteForGamePiece(column: column, emptyRow, type: GamePieceType.black)
                }

                game.checkWinCondition(column, row: emptyRow)
            }
        }
    }

    func pointForColumn(_ column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*TileWidth + TileWidth/2,
            y: CGFloat(row)*TileHeight + TileHeight/2)
    }

    func convertPoint(_ point: CGPoint) -> (success: Bool, column: Int, row: Int) {
        if point.x >= 0 && point.x < CGFloat(NumColumns)*TileWidth &&
            point.y >= 0 && point.y < CGFloat(NumRows)*TileHeight {
                return (true, Int(point.x / TileWidth), Int(point.y / TileHeight))
        } else {
            return (false, 0, 0)  // invalid location
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}
