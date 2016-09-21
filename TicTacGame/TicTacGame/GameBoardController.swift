//
//  ViewController.swift
//  TicTacToe
//
//  Created by Marty Avedon on 9/20/16.
//  Copyright © 2016 Marty Avedon. All rights reserved.
//

import UIKit
class GameBoardController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupGameBoard()
    }
    
    var isFirst = false
    
    var ticTacState = [[State]]()
    
    enum State {
        case empty
        case p1
        case p2
    }
    
    func setupGameBoard() {
        for row in 1...3 {
            for col in 1...3 {
                constructButtonAt(row: row, col: col)
            }
        }
        constructReset()
        resetGameState()
    }
    
    func constructButtonAt(row: Int, col: Int) {
        let xValue = ((col - 1) * 90) + 80 // point, we are shifting by
        let yValue = ((row - 1) * 90) + 170
        
        let frame = CGRect(x: xValue, y: yValue, width: 80, height: 80)
        let button = UIButton(frame: frame)
        button.backgroundColor = .white
        button.tag = Int(String(row) + String(col))!
        button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
        view.addSubview(button)
        
    }
    
    func constructReset() {
        let frame = CGRect(x: 130, y: 550, width: 130, height: 80)
        let resetButton = UIButton(frame: frame)
        resetButton.backgroundColor = .red
        resetButton.titleLabel?.font = UIFont(name:"Futura", size: 30)
        resetButton.setTitle("Let's play", for: .normal)
        resetButton.addTarget(self, action: #selector(handleResetTapped), for: .touchUpInside)
        view.addSubview(resetButton)
    }
    
    func handleButtonTapped (button: UIButton) {
        button.isEnabled = false
        let gridIndex = button.tag
        let gridRow = (gridIndex / 10) - 1
        let gridCol = (gridIndex % 10) - 1
        if isFirst {
            button.backgroundColor = .black
            ticTacState[gridRow][gridCol] = State.p1
            button.setTitle("X", for: .normal)
            button.titleLabel?.font = UIFont(name:"Futura", size: 30)
            isFirst = false
        } else {
            button.backgroundColor = .black
            ticTacState[gridRow][gridCol] = State.p2
            button.setTitle("O", for: .normal)
            button.titleLabel?.font = UIFont(name:"Futura", size: 30)
            isFirst = true
        }
        
        var player1check = checkWinner(player: .p1, board: ticTacState)
        
        var player2check = checkWinner(player: .p2, board: ticTacState)
        
        if player1check == "p1 wins" || player2check == "p2 wins" {
            button.setTitle("Win!", for: .normal)
        }
    }
    
    func handleResetTapped() {
        setupGameBoard()
    }
    
    func resetGameState() {
        for _ in 0..<3 {
            let row = Array(repeating: State.empty, count: 3)
            ticTacState.append(row)
        }
    }
    
    func checkWinner(player: State, board: [[State]]) -> String {
        let player = player
        
        //refactor all this as loops. love yourself
        
        func checkAllRowWinner() -> Bool {
            if ticTacState[0][0] == player
                && ticTacState[0][1] == player
                && ticTacState[0][2] == player {
                    return true
            } else if ticTacState[1][0] == player
                && ticTacState[1][1] == player
                && ticTacState[1][2] == player {
                    return true
            } else if ticTacState[2][0] == player
                && ticTacState[2][1] == player
                && ticTacState[2][2] == player {
                return true
            } else {
                    return false
                }
            }
    
        func checkAllColWinner() -> Bool {
            if ticTacState[0][0] == player
                && ticTacState[1][0] == player
                && ticTacState[2][0] == player {
                    return true
            } else if ticTacState[0][0] == player
                && ticTacState[1][0] == player
                && ticTacState[2][0] == player {
                    return true
            } else if ticTacState[0][0] == player
                && ticTacState[1][0] == player
                && ticTacState[2][0] == player {
                return true
            } else {
                return false
            }
        }
        
        func checkAllDiagWinner() -> Bool {
            if ticTacState[0][0] == player
            && ticTacState[1][1] == player
                && ticTacState[2][2] == player {
                return true
            } else if ticTacState[0][2] == player
            && ticTacState[1][1] == player
            && ticTacState[2][0] == player {
                return true
            } else {
                return false
            }
    }
        let rowWinner = checkAllRowWinner()
        let colWinner = checkAllColWinner()
        let diagWinner = checkAllDiagWinner()
        
        if rowWinner == true || colWinner == true || diagWinner == true {
            return "\(player) wins"
        } else {
            return "\(player) loses"
        }
    }
}
