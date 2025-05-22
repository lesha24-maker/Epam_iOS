public func isPalindrome(input: String) -> Bool {
    var cleanedString = ""
    for character in input.lowercased() {
        if character.isLetter || character.isNumber {
            cleanedString.append(character)
        }
    }
    
    if cleanedString.isEmpty || cleanedString.count == 1 {
        return false
    }
    
    let characters = Array(cleanedString)
    var leftIndex = 0
    var rightIndex = characters.count - 1

    while leftIndex < rightIndex {
        if characters[leftIndex] != characters[rightIndex] {
            return false
        }
        leftIndex += 1
        rightIndex -= 1
    }

    return true
}

public func isBalancedParentheses(input: String) -> Bool {
    var balanceCounter = 0

    for character in input {
        if character == "(" {
            balanceCounter += 1
        } else if character == ")" {
            balanceCounter -= 1

            if balanceCounter < 0 {
                return false
            }
        }
    }

    return balanceCounter == 0
}
