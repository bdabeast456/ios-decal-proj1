//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    @IBOutlet weak var wordDisplay: UILabel!

    @IBOutlet weak var hangmanImageState: UIImageView!
    
    
    @IBOutlet weak var incorrectDisplay: UILabel!
    
    @IBOutlet weak var zKey: UIButton!
    @IBOutlet weak var yKey: UIButton!
    @IBOutlet weak var xKey: UIButton!
    @IBOutlet weak var wKey: UIButton!
    @IBOutlet weak var vKey: UIButton!
    @IBOutlet weak var uKey: UIButton!
    @IBOutlet weak var tKey: UIButton!
    @IBOutlet weak var sKey: UIButton!
    @IBOutlet weak var rKey: UIButton!
    @IBOutlet weak var qKey: UIButton!
    @IBOutlet weak var pKey: UIButton!
    @IBOutlet weak var oKey: UIButton!
    @IBOutlet weak var nKey: UIButton!
    @IBOutlet weak var mKey: UIButton!
    @IBOutlet weak var lKey: UIButton!
    @IBOutlet weak var kKey: UIButton!
    @IBOutlet weak var jKey: UIButton!
    @IBOutlet weak var iKey: UIButton!
    @IBOutlet weak var hKey: UIButton!
    @IBOutlet weak var gKey: UIButton!
    @IBOutlet weak var fKey: UIButton!
    @IBOutlet weak var eKey: UIButton!
    @IBOutlet weak var dKey: UIButton!
    @IBOutlet weak var cKey: UIButton!
    @IBOutlet weak var bKey: UIButton!
    @IBOutlet weak var aKey: UIButton!

    
    @IBOutlet weak var statusBar: UILabel!
    
    let hangmanGame: HangmanData = HangmanData("")
    
    let hangmanImageArray: [UIImage] = [#imageLiteral(resourceName: "hangman1"),
                                       #imageLiteral(resourceName: "hangman2"),
                                       #imageLiteral(resourceName: "hangman3"),
                                       #imageLiteral(resourceName: "hangman4"),
                                       #imageLiteral(resourceName: "hangman5"),
                                       #imageLiteral(resourceName: "hangman6"),
                                       #imageLiteral(resourceName: "hangman7")]
    
    let hangmanPhrases: HangmanPhrases = HangmanPhrases()
    
    var keyboard: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        hangmanGame.resetWithPhrase(phrase)
        wordDisplay.text = hangmanGame.getCorrectString()
        
        keyboard = [
            zKey,
            yKey,
            xKey,
            wKey,
            vKey,
            uKey,
            tKey,
            sKey,
            rKey,
            qKey,
            pKey,
            oKey,
            nKey,
            mKey,
            lKey,
            kKey,
            jKey,
            iKey,
            hKey,
            gKey,
            fKey,
            eKey,
            dKey,
            cKey,
            bKey,
            aKey
        ]
        
        //for key in keyboard {
            //key.titleLabel?.font = key.titleLabel?.font.withSize(key.sizeToFit())
            //key.sizeToFit()
        //    key.titleLabel?.numberOfLines = 1
        //    key.titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingMiddle
        //    key.titleLabel?.minimumScaleFactor = 0.01
        //    key.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        //    key.titleLabel?.adjustsFontSizeToFitWidth = true
            //key.titleLabel?.sizeToFit()
        //}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func playerPushedChar(_ sender: UIButton) {
        if (hangmanGame.isRunning()) {
            if let guess = sender.titleLabel?.text {
                if (hangmanGame.guessMade(guess)) {
                    statusBar.text = "Character Already Guessed!"
                } else {
                    if !hangmanGame.evaluateGuess(guess) {
                        hangmanImageState.image = hangmanImageArray[hangmanGame.getIncorrectGuesses()]
                        statusBar.text = "Nope"
                        incorrectDisplay.text = "Incorrect: " + hangmanGame.getIncorrectString()
                    } else {
                        wordDisplay.text = hangmanGame.getCorrectString()
                        statusBar.text = "Nice!"
                    }
                }
                sender.setTitleColor(UIColor.gray, for: .normal)
            }
            if (!hangmanGame.isRunning()) {
                gameOver()
            }
        }
    }
    
    func gameOver() -> Void {
        statusBar.text = "DONE"
        wordDisplay.text = hangmanGame.getPhrase()
        var endMessage = ""
        if hangmanGame.winConditionMet() {
            endMessage = "Congratulations!"
        } else {
            endMessage = "Better Luck Next Time!"
        }
        let alert = UIAlertController(title: "Game Over",
                                      message: endMessage,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Start Over",
                                      style: UIAlertActionStyle.default,
                                      handler: {
            action in
            self.resetAll()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func resetAll() -> Void {
        let newPhrase: String = hangmanPhrases.getRandomPhrase()
        hangmanGame.resetWithPhrase(newPhrase)
        wordDisplay.text = hangmanGame.getCorrectString()
        hangmanImageState.image = hangmanImageArray[0]
        incorrectDisplay.text = "Incorrect:"
        statusBar.text = "Make a Guess!"
        for key in keyboard {
            key.setTitleColor(UIColor.blue, for: .normal)
        }
    }
}
