//
//  GameViewController.swift
//  swiftConnectFour
//
//  Created by Eric Gu on 10/31/14.
//  Copyright (c) 2014 Eric Gu. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        let path = Bundle.main.path(forResource: file as String, ofType: "sks")

        let sceneData = try? NSData(contentsOfFile: path!, options: .mappedIfSafe)
        let archiver = NSKeyedUnarchiver(forReadingWith: sceneData! as Data)

        archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
        if let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as? SKScene
        {
            archiver.finishDecoding()
            return scene
        }

        return nil
    }
}

class GameViewController: UIViewController {
    //properties
    var scene: GameScene!
    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = true
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill

        game = Game()
        scene.game = game
        scene.addTiles()
        skView.presentScene(scene)
    }

    @IBAction func newGame(_ sender: AnyObject) {
        viewDidLoad()
        isFinished = false

    }
    override var shouldAutorotate : Bool {
        return true
    }

    /*
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return Int(UIInterfaceOrientationMask.allButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.all.rawValue)
        }
    }
 */

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
