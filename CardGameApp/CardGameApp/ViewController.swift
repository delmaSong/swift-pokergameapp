//
//  ViewController.swift
//  CardGameApp
//
//  Created by delma on 05/02/2020.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var playerCount = PokerGame.PlayerCount.one
    private var studNumber = PokerGame.Stud.seven
    private var pokerGame: PokerGame!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    let studSegmented: UISegmentedControl = {
        let studs = ["7 Cards", "5 Cards"]
        let segmentedControl = UISegmentedControl(items: studs)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderColor = UIColor.white.cgColor
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.addTarget(self, action: #selector(studSegmentControl(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    let playerSegmented: UISegmentedControl = {
        let playerCount = ["1명", "2명", "3명", "4명"]
        let segmentedControl = UISegmentedControl(items: playerCount)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderColor = UIColor.white.cgColor
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.addTarget(self, action: #selector(playerCountControl(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    let wholeGameStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    func setUI() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_pattern")!)
        setCardsWithImages(playerCount: playerCount, stud: studNumber)
        
        studSegmented.center = CGPoint(x: self.view.frame.width/2, y: 90)
        self.view.addSubview(studSegmented)
        self.view.addSubview(playerSegmented)
        
        playerSegmented.translatesAutoresizingMaskIntoConstraints = false
        
        let titleTextAttributesNormal = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributesNormal, for: .normal)
        
        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
        
        self.view.addSubview(wholeGameStack)
        
        setStackContraints()
    }
    
    func setStackContraints() {
        let constraints = [
            playerSegmented.leadingAnchor.constraint(equalTo: studSegmented.leadingAnchor),
            playerSegmented.trailingAnchor.constraint(equalTo: studSegmented.trailingAnchor),
            playerSegmented.topAnchor.constraint(equalTo: studSegmented.bottomAnchor, constant: 10),
            wholeGameStack.topAnchor.constraint(equalTo: playerSegmented.bottomAnchor, constant: 30),
            wholeGameStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            wholeGameStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func cardImageView(named: String) -> UIImageView {
        let image = UIImageView(image: UIImage(named: named))
        return image
    }
    
    func makePlayerLabel(playerNumber: Int) -> UILabel {
        let label = UILabel()
        label.text = "Player \(playerNumber)"
        label.textColor = .white
        label.font.withSize(10.0)
        return label
    }
    
    func makeGameStack(playerNumber: Int, cardImageStack: UIStackView) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(makePlayerLabel(playerNumber: playerNumber))
        stackView.addArrangedSubview(cardImageStack)
        return stackView
    }
    
    func makeCardImageStack() -> UIStackView{
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = -10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    func setCardsWithImages(playerCount: PokerGame.PlayerCount, stud: PokerGame.Stud) {
        wholeGameStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        pokerGame = PokerGame(playerCount: playerCount, stud: stud)
        pokerGame.allocateCards()
        let allCards = pokerGame.playersCardInfo()
        var number = 1
        for cards in allCards {
            let cardImageStack2 = makeCardImageStack()
            for card in cards {
                let cardImage = cardImageView(named: "\(card.patternImageMatching)\(card.numberImageMatching)")
                cardImage.heightAnchor.constraint(equalTo: cardImage.widthAnchor, multiplier: 1.27).isActive = true
                cardImageStack2.addArrangedSubview(cardImage)
            }
            let gameStack = makeGameStack(playerNumber: number, cardImageStack: cardImageStack2)
            number += 1
            wholeGameStack.addArrangedSubview(gameStack)
        }
        
    }

    
    @objc func studSegmentControl(_ segmentedControl: UISegmentedControl) {
        switch studSegmented.selectedSegmentIndex {
        case 0:
            studNumber = .seven
        case 1:
            studNumber = .five
        default:
            break
        }
        setCardsWithImages(playerCount: playerCount, stud: studNumber)
    }
    
    @objc func playerCountControl(_ segmentedControl: UISegmentedControl) {
        switch playerSegmented.selectedSegmentIndex {
        case 0:
            playerCount = .one
        case 1:
            playerCount = .two
        case 2:
            playerCount = .three
        case 3:
            playerCount = .four
        default:
            break
        }
        setCardsWithImages(playerCount: playerCount, stud: studNumber)
        
    }
    
}

