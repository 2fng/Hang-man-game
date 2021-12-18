//
//  ViewController.swift
//  Challenge3
//
//  Created by Hua Son Tung on 18/12/2021.
//

import UIKit

class ViewController: UIViewController {
    var hpLabel: UILabel!
    var scoreLabel: UILabel!
    var answersLabel: UILabel!
    var numberOfLetters: UILabel!
    var vowelsButtons = [UIButton]()
    var consonantsButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    
    var answer = ""
    var questions = [String]()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        //hpLabel
        hpLabel = UILabel()
        hpLabel.translatesAutoresizingMaskIntoConstraints = false
        hpLabel.textAlignment = .right
        hpLabel.text = "HP: 0"
        view.addSubview(hpLabel)
        
        //scoreLabel
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .left
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        //answersLabel
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.textAlignment = .center
        answersLabel.text = "This is the answer"
        answersLabel.font = UIFont.systemFont(ofSize: 34)
        view.addSubview(answersLabel)
        
        //numberOfLetters
        numberOfLetters = UILabel()
        numberOfLetters.translatesAutoresizingMaskIntoConstraints = false
        numberOfLetters.textAlignment = .center
        numberOfLetters.text = "7 letters"
        numberOfLetters.textColor = .systemGray3
        numberOfLetters.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(numberOfLetters)
        
        //vowelsButtonsView
        let vowelButtonView = UIView()
        vowelButtonView.translatesAutoresizingMaskIntoConstraints = false
        vowelButtonView.layer.borderColor = UIColor.systemGray3.cgColor
        vowelButtonView.layer.borderWidth = 1
        vowelButtonView.layer.cornerRadius = 10
        view.addSubview(vowelButtonView)
        
        //consonantButtonView
        let consonantButtonView = UIView()
        consonantButtonView.translatesAutoresizingMaskIntoConstraints = false
        consonantButtonView.layer.borderColor = UIColor.systemGray3.cgColor
        consonantButtonView.layer.borderWidth = 1
        consonantButtonView.layer.cornerRadius = 10
        view.addSubview(consonantButtonView)
        
        //Auto layout
        NSLayoutConstraint.activate([
            //hpLabbel
            hpLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            hpLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
        
            //scoreLabel
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            
            //answersLabel
            answersLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70),
            answersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //numberOfLetters
            numberOfLetters.topAnchor.constraint(equalTo: answersLabel.bottomAnchor, constant: 10),
            numberOfLetters.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            numberOfLetters.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            //vowelButtonView
            vowelButtonView.topAnchor.constraint(equalTo: numberOfLetters.bottomAnchor, constant: 50),
            vowelButtonView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            vowelButtonView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            vowelButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vowelButtonView.heightAnchor.constraint(equalToConstant: 50),
            
            //consonantButtonView
            consonantButtonView.topAnchor.constraint(equalTo: vowelButtonView.bottomAnchor, constant: 10),
            consonantButtonView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            consonantButtonView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            consonantButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            consonantButtonView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10)

        ])
        
        //Width and height values for buttons
        let width = 68
        let height = 50
        let numberOfConsonant = 20
        var count = 0
        
        //Create button in vowelButtonView
        for col in 0..<5 {
            //Create button
            let letterButton = UIButton(type: .system)
            letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            
            //Temporary text
            letterButton.setTitle("A", for: .normal)
            
            //Calculate the frame
            let frame = CGRect(x: col * width, y: 0, width: width, height: height)
            letterButton.frame = frame
            vowelButtonView.addSubview(letterButton)
            
        }
        //Create button in consonantButtonView
        for row in 0..<5 {
            for col in 0..<5 {
                if count <= numberOfConsonant {
                    count += 1
                    //Create button
                    let letterButton = UIButton(type: .system)
                    letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
                    
                    //Temporary text
                    letterButton.setTitle("A", for: .normal)
                    
                    //Calculate the frame
                    let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                    letterButton.frame = frame
                    consonantButtonView.addSubview(letterButton)
                } else {
                    count = 0
                    return
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadAnimalsTxt()
        startGame()
    }
    
    func loadAnimalsTxt() {
        
        if let animalTxtFileURL = Bundle.main.url(forResource: "animals", withExtension: "txt") {
            if let animalTxtContent = try? String(contentsOf: animalTxtFileURL) {
                questions = animalTxtContent.components(separatedBy: "\n")
                questions.shuffle()
            }
        } else {
            print("Error loading word")
        }
    }
    
    func startGame() {
        answer = questions.randomElement() ?? "404 No Word Found"
        var questionForm = ""
        var numberOfCharacter = 0
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            for letter in self!.answer {
                var strLetter = String(letter)
                
                if letter != " " {
                    strLetter = "?"
                    questionForm.append(contentsOf: strLetter)
                    numberOfCharacter += 1
                } else {
                    questionForm.append(contentsOf: strLetter)
                }
            }
        }
        
        print("Answer: \(answer)")
        print("Question Form: \(questionForm)")
        
        DispatchQueue.main.async { [weak self] in
            self?.answersLabel.text = questionForm
            self?.numberOfLetters.text = "\(numberOfCharacter) letters"
        }
    }


}

