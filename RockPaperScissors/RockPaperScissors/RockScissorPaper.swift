//
//  RockPaperScissors - main.swift
//  Created by Lingo, 우롱차.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

enum HandType: Int, CaseIterable {
    case scissor = 1
    case rock = 2
    case paper = 3
    
    static var randomPick: Int? {
        return Self.allCases.randomElement()?.rawValue
    }
    
    static func isHandType(_ value: Int) -> Bool {
        if let _ = HandType(rawValue: value) {
            return true
        }
        return false
    }
}

func getPlayerInput() -> Int? {
    guard let playerInput = readLine(),
          let playerIntInput = Int(playerInput)
    else {
        return nil
    }
    
    guard playerIntInput != Settings.exitCode else {
        return playerIntInput
    }
    
    guard HandType.isHandType(playerIntInput) else {
        return nil
    }

    return playerIntInput
}

func checkGameResult(player playerInput: Int, computer computerInput: Int) -> GameResult {
    let computerLoseCondition = (computerInput % 3) + 1
    
    if playerInput == computerLoseCondition {
        return .playerWin
    } else if playerInput == computerInput {
        return .playerDraw
    } else {
        return .playerLose
    }
}

func showGameResult(_ result: GameResult) {
    switch result {
    case .playerWin:
        print(GameDisplayMessage.playerDidWin)
    case .playerLose:
        print(GameDisplayMessage.playerDidLose)
    case .playerDraw:
        print(GameDisplayMessage.playerDidDraw)
    }
}

func startGame() {
    print(GameDisplayMessage.menu, terminator: "")

    guard let playerInput = getPlayerInput()
    else {
        print(GameDisplayMessage.invalidPlayerInput)
        startGame()
        return
    }
    if playerInput == Settings.exitCode {
        print(GameDisplayMessage.gameDidEnd)
        return
    }
    guard let computerInput = HandType.randomPick else {
        print(GameDisplayMessage.error)
        return
    }
    let gameResult = checkGameResult(player: playerInput, computer: computerInput)
    
    showGameResult(gameResult)
    
    if gameResult == .playerDraw {
        startGame()
        return
    }
    
    guard let mukZziPpaGameResult = startMukZziPpaGame(gameResult) else {
        return
    }
    
    showMukZziPpaGameResult(mukZziPpaGameResult)
}
