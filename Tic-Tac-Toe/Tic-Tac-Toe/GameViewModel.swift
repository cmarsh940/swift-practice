//
//  GameViewModel.swift
//  Tic-Tac-Toe
//
//  Created by Cam on 8/7/21.
//

import SwiftUI

//observableObject: Anytime object changes in the view it will publish and update

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled = false
    @Published var alertItem: AlertItem?
    
    func processPlayerMove(for position: Int) {
        if isSquareOccupied(in: moves, forIndex: position) { return }
        moves[position] = Move(player: .human, boardIndex: position)
        
        // check for win condition or draw
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        
        isGameBoardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isGameBoardDisabled = false
            
            // check for win condition or draw
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.ComputerWin
                return
            }
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }
            
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    //    If Ai can win, then win
    //    If Ai cant win, then block
    //    If Ai cant block, then take middle square
    //    If Ai cant take middle square, take random available square
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        //    If Ai can win, then win
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
//        parsing the array of board indexs for that player
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPositions = Set(computerMoves.map { $0.boardIndex } )
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvaiable = isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvaiable { return winPositions.first! }
            }
        }
        
        //    If Ai cant win, then block
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvaiable = isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvaiable { return winPositions.first! }
            }
        }
        
        
        //    If Ai cant block, then take middle square
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare) {
            return centerSquare
        }
        
        
        //    If Ai cant take middle square, take random available square
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
//        all available win patterns
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
//        parsing the array of board indexs for that player
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex } )
        
//        check win conditions against player moves and if they match then return true else no win
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }

}
