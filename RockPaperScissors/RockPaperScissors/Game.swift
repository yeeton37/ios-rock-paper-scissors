//
//  functions.swift
//  RockPaperScissors
//
//  Created by 전민수 on 2022/04/18.
//

import Foundation

struct Game {
    enum InputOfRockPaperScissors: Int {
        case quit, scissors, rock, paper, error
        
        var message: String {
            switch self {
            case .quit:
                return "게임 종료"
            case .scissors:
                return "가위"
            case .rock:
                return "바위"
            case .paper:
                return "보"
            case .error:
                return "잘못된 입력입니다. 다시 시도해주세요."
            }
        }
    }
    
    enum MukJjiPpa: Int {
        case quit, muk, jji, ppa, error
        
        var koreanName: String {
            switch self {
            case .quit:
                return "게임 종료"
            case .muk:
                return "묵"
            case .jji:
                return "찌"
            case .ppa:
                return "빠"
            case .error:
                return "잘못된 입력입니다. 다시 시도해주세요."
            }
        }
    }
    
    enum GameResult {
        case usersVictory
        case computersVictory
        case tie
    }
    
    let menu: String = "가위(1), 바위(2), 보(3)! <종료 : 0> : "
    
    func startRPS() {
        let userMenuChoice = selectMenuByInput()
        decideProcessBy(userMenuChoice)
    }
    
    func selectMenuByInput() -> InputOfRockPaperScissors {
        print(menu, terminator: "")
        guard let userInput = readLine() else {
            return .error
        }
        guard let numberChoice = Int(userInput) else {
            return .error
        }
        
        return InputOfRockPaperScissors(rawValue: numberChoice) ?? .error
    }
    
    func decideProcessBy(_ menuChoice: InputOfRockPaperScissors) {
        switch menuChoice {
        case .quit:
            print(InputOfRockPaperScissors.quit.message)
        case .scissors, .rock, .paper:
            let eachPick: (InputOfRockPaperScissors, InputOfRockPaperScissors) = playRPS(by: menuChoice)
            let gameResult = pickOutWinner(from: eachPick)
            printResult(basedOn: gameResult)
            
            restartIfTie(judgingBy: gameResult)
        default:
            print(InputOfRockPaperScissors.error.message)
            startRPS()
        }
    }
    
    func playRPS(by menuChoice: InputOfRockPaperScissors) -> (InputOfRockPaperScissors, InputOfRockPaperScissors) {
        let myRpsPick = menuChoice
        guard let computerRpsPick = InputOfRockPaperScissors(rawValue: Int.random(in: InputOfRockPaperScissors.scissors.rawValue...InputOfRockPaperScissors.paper.rawValue)) else { return (.quit, .quit) }
        
        return (myRpsPick, computerRpsPick)
    }
    
    func pickOutWinner(from pickOf: (user: InputOfRockPaperScissors, computer: InputOfRockPaperScissors)) -> GameResult {
        if pickOf.computer == pickOf.user {
            return .tie
        }
        
        switch (pickOf.user, pickOf.computer) {
        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
            return .usersVictory
        default:
            return .computersVictory
        }
    }
    
    func printResult(basedOn gameResult: GameResult) {
        switch gameResult {
        case .usersVictory:
            print("이겼습니다!")
            print("게임 종료")
        case .computersVictory:
            print("졌습니다!")
            print("게임 종료")
        default:
            print("비겼습니다")
        }
    }
    
    func restartIfTie(judgingBy gameResult: GameResult) {
        if gameResult == .tie {
            startRPS()
        }
    }
}
