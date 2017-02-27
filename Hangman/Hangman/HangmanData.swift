//
//  HangmanData.swift
//  Hangman
//
//  Created by Brandon Pearl on 2/25/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import Foundation

class HangmanData {
    var phrase: String
    var guesses: Int = 0
    var incorrectGuesses: Int = 0
    var incorrectChar: [String] = []
    var correctString: String = ""
    var correctMap: [(String, Bool)] = []
    let maxGuesses: Int
    let spacer: String = "    "
    
    init (_ phrase: String, _ maxGuesses: Int=6) {
        self.phrase = phrase
        self.maxGuesses = maxGuesses
    }
    
    func resetWithPhrase(_ phrase: String) -> Void {
        self.phrase = phrase.lowercased()
        guesses = 0
        incorrectGuesses = 0
        incorrectChar = []
        correctMap = []
        correctString = ""
        for c in self.phrase.characters.indices[self.phrase.startIndex..<self.phrase.endIndex] {
            let currChar: String = String(self.phrase[c])
            if currChar == " " {
                correctString += spacer
                correctMap.append((currChar, true))
            } else {
                correctString += "_ "
                correctMap.append((currChar, false))
            }
        }
    }
    
    func guessMade(_ guess: String) -> Bool {
        return incorrectChar.contains(guess) || correctString.contains(guess)

    }
    
    func evaluateGuess(_ guess: String) -> Bool {
        guesses += 1
        if phrase.contains(guess) {
            for i in 0...(correctMap.count-1) {
                let (c, _) = correctMap[i]
                if c == guess {
                    correctMap[i] = (c, true)
                }
            }
            updateCorrect()
            return true
        }
        incorrectChar.append(guess)
        incorrectGuesses += 1
        return false
    }
    
    func updateCorrect() -> Void {
        correctString = ""
        for i in 0...(correctMap.count-1) {
            let (c, b) = correctMap[i]
            if b {
                if c == " " {
                    correctString += spacer
                } else {
                    correctString += c + " "
                }
            } else {
                correctString += "_ "
            }
        }
    }
    
    // Check if end state has been reached
    func isRunning() -> Bool {
        return incorrectGuesses < maxGuesses && !winConditionMet()
    }
    
    // Only call after isRunning returns false
    func winConditionMet() -> Bool {
        return !correctString.contains("_")
    }
    
    // Getter methods
    func getCorrectString() -> String {
        return correctString
    }
    
    func getIncorrectGuesses() -> Int {
        return incorrectGuesses
    }
    
    func getIncorrectString() -> String {
        var listString: String = ""
        for i in 0...incorrectChar.count-1 {
            if i < incorrectChar.count - 1 {
                listString += incorrectChar[i] + ", "
            } else {
                listString += incorrectChar[i]
            }
        }
        return listString
    }
    
    func getPhrase() -> String {
        return phrase
    }
}
