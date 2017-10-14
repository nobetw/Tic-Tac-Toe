//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Brandon No on 10/4/17.
//  Copyright © 2017 nobetw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var turnCount = 0 // Turn counter
    var gameState = 0 // -1 when X's win, 1 when O's win and 0 when game is in progress
    var board = Array(repeating: 0, count: 9) // Linear array to keep track of a 9 slot board
    
    let winningCombos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], // horizontal slots
        [0, 3, 6], [1, 4, 7], [2, 5, 8], // vertical slots
        [0, 4, 8], [2, 4, 6]] // diagonal slots
    
    // todo: create gameStatus label
    
    // todo: link to UI buttons
    // Called when slot (button) is selected
    // Restarts game when each round concludes
    func slotSelected(_ button: UIButton) {
        if gameState == 0 && turnCount < 9{
            if(updatedSlot(button)) {
                gameState = getGameStatus()
                if gameState == 1 {
                    print("O's win!")
                } else if gameState == -1 {
                    print("X's win!")
                } else {
                    turnCount += 1
                    // Draw when no winner has been determined after all slots have been occupied
                    if turnCount == 9 {
                        print("Draw!")
                    }
                }
            }
        } else {
            refreshGameState()
        }
    }
    
    // todo: provide O and X images for button image
    // Returns TRUE if selected slot is updated
    // Returns FALSE if slot has already been selected
    // If 'O', supply board with 1
    // If 'X', supply board with -1
    func updatedSlot(_ button: UIButton) -> Bool {
        if button.currentImage == nil {
            if turnCount % 2 == 0 {
                button.setImage(UIImage(named:"O"), for: UIControlState.normal)
                board[button.tag - 1] = 1
            } else {
                button.setImage(UIImage(named:"X"), for: UIControlState.normal)
                board[button.tag - 1] = -1
            }
            return true
        }
        return false
    }
    
    // Return 0 if no winner, else return 1 for O and -1 for X
    // winningCombos is currently guaranteed to have size of 3 for a board count of 9
    func getGameStatus() -> Int {
        for combo in winningCombos {
            // Check tuples by intersection
            if (board[combo[0]], board[combo[1]]) == (board[combo[1]], board[combo[2]]) {
                return board[combo[0]]
            }
        }
        return 0
    }
    
    // Reinitialize globals for new game
    func refreshGameState() {
        turnCount = 0
        gameState = 0
        board = Array(repeating: 0, count: 9)
        
        // Clear image used for each button in View
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.setImage(nil, for: UIControlState.normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



