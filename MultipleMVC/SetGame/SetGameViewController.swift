//
//  ViewController.swift
//  drawing practice
//
//  Created by Pawel Misiak on 10/25/18.
//  Copyright © 2018 Pawel Misiak. All rights reserved.
//

import UIKit

class SetGameViewController: UIViewController {
    
    override func viewDidLoad() {
        updateViewFromModel()
        super.viewDidLoad()
    }
    
    
    private lazy var game = Set()
    var delay = false
    var delayTime = 0.0
    var visibleCards = 12
    var maxNumberOfVisible = 81
    
    @IBAction func reset() { // reset the game to the original state
        for card in gameView.subviews{
            card.removeFromSuperview()
        }
        delay = false
        addThree.isEnabled = true
        addThree.backgroundColor = #colorLiteral(red: 1, green: 0.09332232228, blue: 0, alpha: 1)
        game = Set()
        visibleCards = 12
        viewDidLoad()
        cardsToOut = []
        maxNumberOfVisible = 81
    }
    
    @IBOutlet weak var gameView: UIView!{
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(addThreeCards))
            swipe.direction = [.down]
            gameView.addGestureRecognizer(swipe)
        }
    }
    @IBAction func rotate(_ sender: UIRotationGestureRecognizer) {
        if sender.state == .ended {
            shuffle()
        }
    }
    
    private func shuffle() {
        var decreasingIterator = gameView.subviews.count-1
        while decreasingIterator > 0 {
            let rand = Int(arc4random_uniform(UInt32(decreasingIterator)))
            gameView.exchangeSubview(at: decreasingIterator, withSubviewAt: rand)
            decreasingIterator -= 1
        }
    }
    
    @objc private func addThreeCards(){
        visibleCards += 3
        updateViewFromModel()
    }
    @IBOutlet weak var ScoreCount: UILabel! //label that will keep track of the score
    @IBOutlet weak var addThree: UIButton!  //button to add three cards
    @IBAction func addThree(_ sender: UIButton) { //by changing count of visible buttons updateViewFromModel will automatically unlock the disabled buttons and associate 3 more cards
        addThreeCards()
    }
    var cardsToOut = Array<Int>()

    @IBAction func touchCard(_ sender: UITapGestureRecognizer) {
        var wasCalled = false
        if sender.state == .ended {
            let location = sender.location(in: gameView)

            if let tappedView = gameView.hitTest(location, with: nil) {
                if let cardIndex = gameView.subviews.index(of: tappedView) {

                    game.chooseCard(index: cardIndex)

                    if game.arrayOfMatchedCardIndices.count == 3 {
                        for index in game.arrayOfMatchedCardIndices {
                            if game.weGotAMatch{
                                gameView.subviews[index].backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                                ScoreCount.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                                cardsToOut = game.arrayOfMatchedCardIndices // array of index to remove from the screen
                            }
                            if game.wrongMatch{
                                gameView.subviews[index].backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
                                ScoreCount.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
                                game.cardsOnTable[index].isSelected = false
                            }
                            wasCalled = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.ScoreCount.backgroundColor = UIColor.clear
                                if self.game.weGotAMatch {
                                    self.game.score += 3
                                }
                                if self.game.wrongMatch {
                                    self.game.score -= 3
                                }
                                self.game.weGotAMatch = false
                                self.game.wrongMatch = false
                                self.updateViewFromModel()
                            })
                        }
                        game.arrayOfMatchedCardIndices.removeAll()
                    }
                }
            }
        }
        if !wasCalled {
            updateViewFromModel();
        }
    }

    private func addCardToTheEnd() -> CardView {
        let cardView = CardView()
        let card = game.cards.remove(at: 0)
        game.cardsOnTable.append(card) // add the card to the end of array
        
        cardView.numberOfObjects = card.symbolCount
        switch card.symbol {
        case "diamond": cardView.shape = "diamond"
        case "oval": cardView.shape = "oval"
        case "squigle": cardView.shape = "squigle"
        default: break
        }
        
        switch card.color {
        case "blue": cardView.color = UIColor.cyan
        case "green": cardView.color = UIColor.green
        case "purple": cardView.color = UIColor.purple
        default: break
        }
        
        switch card.shade {
        case "full": cardView.shade = "full"
        case "striped": cardView.shade = "striped"
        default:
            cardView.shade = "empty"
        }
        
//        for cardView in gameView.subviews {
//            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(standOut(_:))))
//        }
        return cardView
    }
    
    @objc func standOut(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let chosenCardView = recognizer.view as? CardView {
                print(chosenCardView.numberOfObjects)
//                chosenCardView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
        default:
            break
        }
    }

    
    private func insertCard(index: Int) {
        let cardView = CardView()
        var card = Card()
        if game.cards.count > 0 {
            card = game.cards.remove(at: 0)
            game.cardsOnTable[index] = card // add the card at the specific location
        } else {
            game.cardsOnTable.remove(at: index)
        }
        
        cardView.numberOfObjects = card.symbolCount
        switch card.symbol {
        case "diamond": cardView.shape = "diamond"
        case "oval": cardView.shape = "oval"
        case "squigle": cardView.shape = "squigle"
        default: break
        }
        
        switch card.color {
        case "blue": cardView.color = UIColor.cyan
        case "green": cardView.color = UIColor.green
        case "purple": cardView.color = UIColor.purple
        default: break
        }
        
        switch card.shade {
        case "full": cardView.shade = "full"
        case "striped": cardView.shade = "striped"
        default:
            cardView.shade = "empty"
        }
        gameView.subviews[index].removeFromSuperview()
        if game.cards.count > 0 {
            gameView.insertSubview(cardView, at: index)
        }
        
    }
    
    @IBAction func peakButton(_ sender: UIButton) { // button will highlight 3 cards for one second that currently form a match and will deduct points from the current score
        game.score -= 4
        var found = false
        for i in 0..<gameView.subviews.count{
            for j in i+1..<visibleCards{
                for k in j+1..<visibleCards{
                    if game.checkForMatch(
                        card1: game.cardsOnTable[i],
                        card2: game.cardsOnTable[j],
                        card3: game.cardsOnTable[k]) {
                        
                        found = true
                        gameView.subviews[i].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                        gameView.subviews[j].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                        gameView.subviews[k].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                        ScoreCount.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { // asynchronous function that allows delay in farther execution without pausing the entire system
                            self.updateViewFromModel()
                        })
                    }
                    if found{break}
                }
                if found{break}
            }
            if found{break}
        }
    }
    
    
    func showCard(card: UIView){
        var int = 0.0
        if delay{
            int = delayTime
        }
            card.alpha = 0
            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: 1.0,
                delay: int,
                options: [],
                animations: {
                    card.transform = CGAffineTransform.identity.translatedBy(x: 500.0, y: -500.0)
                    card.alpha = 1
            }
                //                completion: <#T##((UIViewAnimatingPosition) -> Void)?##((UIViewAnimatingPosition) -> Void)?##(UIViewAnimatingPosition) -> Void#>
            )
    }
    
    func addCard(){
        if gameView.subviews.count < 12 {
            delay = true
            delayTime += 0.1
        }
        let currentCard = addCardToTheEnd()
        gameView.addSubview(currentCard)
        showCard(card: currentCard)
        delay = false
    }
    
    func checkIfAllDisabled() -> Bool{ //necessary to check if the game is about to come to the end
        if game.cardsOnTable.count < 3 {
            return true
        }
        return false
    }
    
    private func updateViewFromModel() {
        delayTime = 0 // reset delay after each use
        
        
        if game.cards.count < 3 || visibleCards == 81 {
            addThree.isEnabled = false
            addThree.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        }
        ScoreCount.text = "Score: \(game.score)" // adjust the score here
        
        if visibleCards > gameView.subviews.count && game.cards.count > 0 {
            while visibleCards != gameView.subviews.count {
                addCard()
            }
        }
        
        if checkIfAllDisabled() { //change the score to a message with score count indicating that the game is over
            ScoreCount.text = "You have finished the game with score: \(game.score)"
        }
        
        if gameView.subviews.count <= maxNumberOfVisible {
            
            for index in 0..<gameView.subviews.count {
                
                let currentCard = game.cardsOnTable[index]
                if currentCard.isSelected {
                    gameView.subviews[index].backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                } else {
                    gameView.subviews[index].backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }
            }
            
        }
        if cardsToOut.count == 3 {
            for index in 0..<3 {
                insertCard(index: cardsToOut[index])
                gameView.setNeedsLayout()
                gameView.setNeedsDisplay()
            }
            maxNumberOfVisible -= 3
            
            cardsToOut = []
            
        }
    }
}

