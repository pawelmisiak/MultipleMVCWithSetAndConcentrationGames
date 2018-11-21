//
//  Concentration.swift
//  MultipleMVC
//
//  Created by Pawel Misiak on 11/20/18.
//  Copyright © 2018 Pawel Misiak. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = Array<ConcentrationCard>() // this equals [Card]() // parents are initializing an empty array
    
    var numberOfFlips = 0 // tracks number of moves
    
    // Following three var's will help with counting points
    var points = 0
    var seenCards = [Int]()
    var unseen = true //set the initial value to true as the card wasn't seen yet
    
    private var indexOfOneAndOnlyFaceUpCard: Int? // is initialized to be nil
    
    func chooseCard(at index: Int) { // this is not private because viewcontroller calls it so its public
        numberOfFlips += 1
        unseen = true // set always that the card wasn't seen yet
        
        for currCard in seenCards.indices { // check if the card was already seen
            if seenCards[currCard] == index {
                points -= 1
                unseen = false // the card was seen so change the value to adjust the points
            }
        }
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    if unseen == true { // get two points for unseen cards
                        points += 2
                    } else {
                        points += 3 // 3 points because if the second choise of our cards
                        // was already seen than we would get only 1 point
                        // so -1 + 3 = 2 points for correct guess
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil;
            } else {    // first chosen card from two will always go here
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        seenCards.append(index) // add the card to our seen collection
    }
    
    init(numberOfPairsOfCards: Int) {
        // Initialize always with fresh set of values
        numberOfFlips = 0
        points = 0
        seenCards = [Int]()
        
        for _ in 0..<numberOfPairsOfCards { // underscore says there is no var associated with this loop
            let card = ConcentrationCard()
            cards += [card, card]
        }
        
        //         Shuffling the cards using swapAt and arc4random with upper bound
        var decreasingIterator = cards.count-1
        while decreasingIterator > 0 {
            let rand = Int(arc4random_uniform(UInt32(decreasingIterator)))
            cards.swapAt(decreasingIterator, rand)
            decreasingIterator -= 1
        }
        
    }
}
