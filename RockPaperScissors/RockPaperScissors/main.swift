enum GameError: Error {
    case invalidInput
    case unknownError
}
enum GameResult: String {
    case win = "이겼습니다!"
    case lose = "졌습니다!"
    case draw = "비겼습니다!"
}
class RockScissorPaper {
    var handOfComputer = Int.random(in: 1...3)
    var handOfUser = Int.random(in: 1...3)
    func renewComputerHand() {
        handOfUser = 0
        handOfComputer = Int.random(in: 1...3)
    }
    func startGame() {
        var userInput = 0
        outer: while true {
            renewComputerHand()
            showMenu()
            do {
                userInput = try getUserInput()
                if userInput == 0 {
                    break outer
                }
            } catch {
                print("잘못된 입력입니다. 다시 시도해주세요.")
                continue outer
            }
            handOfUser = userInput
            let winner = returnResultOfGame()
            showResult(winner)
        }
    }
    func returnResultOfGame() -> GameResult {
        switch (handOfUser, handOfComputer) {
        case (1, 1), (2, 2), (3, 3):
            return .draw
        case (1, 3), (2, 1), (3, 2):
            return .win
        case (1, 2), (2, 3), (3, 1):
            return .lose
        default:
            print("알 수 없는 오류입니다.")
            return .lose
        }
    }
    func showMenu() {
        print("가위(1). 바위(2). 보(3)! <종료 : 0>", terminator: " : ")
    }
    func getUserInput() throws -> Int {
        guard let unsafeUserInput = readLine() else {
            throw GameError.invalidInput
        }
        
        guard let integerUserInput = Int(unsafeUserInput) else {
            throw GameError.invalidInput
        }
        
        switch integerUserInput {
        case 0, 1, 2, 3:
            return integerUserInput
        default:
            throw GameError.invalidInput
        }
    }
    func showResult(_ input: GameResult) {
        print(input.rawValue)
    }
}

RockScissorPaper().startGame()
