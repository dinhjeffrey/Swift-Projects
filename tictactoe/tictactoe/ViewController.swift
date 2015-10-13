//
//  ViewController.swift
//  tictactoe
//
//  Created by Akhil Nadendla on 6/17/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button: UIButton!
    
    @IBOutlet var gameOverLabel: UILabel!
    
    var counter = 0
    
    var gamestate = [0,0,0,0,0,0,0,0,0]
    
    var gameActive = true
    
    var winningCombination = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    @IBOutlet var playagain: UIButton!
    
    @IBAction func playAgainPressed(sender: AnyObject) {
        gamestate = [0,0,0,0,0,0,0,0,0]
        gameActive = true
        counter = 0
        var button : UIButton
        for var i = 0 ; i < 9 ; i++ {
            button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, forState: .Normal)
        }
        
        gameOverLabel.hidden = true
        playagain.hidden = true
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x, gameOverLabel.center.y)
        playagain.center = CGPointMake(playagain.center.x, playagain.center.y)

    }
    
    func checkIfGameOver() -> Bool{
        for( var i = 0; i < winningCombination.count; i++){
            var curr = winningCombination[i]
            if gamestate[curr[0]] == gamestate[curr[1]] && gamestate[curr[1]] == gamestate[curr[2]]{
                if gamestate[curr[0]] != 0 {
                    return true
                }
            }
        }
        return false
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        if gameActive {
            var image = UIImage()
            var squareOrCross = 0
            
            if counter % 2 == 0 {
                image = UIImage(named: "cross.png")!
                squareOrCross = 1
            }
            else {
                image = UIImage(named: "nought.png")!
                squareOrCross = 2
            }
            //replace button with sender so each button updates
            //its own square
            //button.setImage(image, forState: .Normal)
            
            if gamestate[sender.tag] == 0 {
                sender.setImage(image, forState: .Normal)
                gamestate[sender.tag] = squareOrCross
                counter++;
            }
            //we tagged each button in the main.storyboard
            print(sender.tag)
            if checkIfGameOver() {
                gameActive = false
                gameOverLabel.text = "GAME OVER"
                if squareOrCross == 1 {
                    gameOverLabel.text = gameOverLabel.text! + " CROSSES HAVE WON"
                }
                else {
                    gameOverLabel.text = gameOverLabel.text! + " CIRCLES HAVE WON"
                }
                gameOverLabel.hidden = false
                playagain.hidden = false
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x+400, self.gameOverLabel.center.y)
                    self.playagain.center = CGPointMake(self.playagain.center.x+400, self.playagain.center.y)
                })
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gameOverLabel.hidden = true
        playagain.hidden = true
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x, gameOverLabel.center.y)
        playagain.center = CGPointMake(playagain.center.x, playagain.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

