//
//  QuizChoiceViewController.swift
//  MemorizeEnglish
//
//  Created by apple on 2018/08/13.
//  Copyright © 2018年 Chris Rashad Kim. All rights reserved.
//

import UIKit

class QuizChoiceViewController: UIViewController {
    
    @IBAction func QuizType(_ sender: UISegmentedControl) {
        WordListSingleton.NOWFlag = WordListSingleton.NOWFlagB
        WordListSingleton.randomStartFlag = WordListSingleton.randomStartFlagB
        switch sender.selectedSegmentIndex {
        case 0:
            print("4Choices")
            nextQuizType(id: "Choose")
        case 1:
            print("Write")
            nextQuizType(id: "Write")
        case 2:
            print("Fill in")
            nextQuizType(id: "Fill")
        default:
            print("no quiz type")
        }
    }
    
    func nextQuizType(id: String) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: id)
        nextVC?.modalTransitionStyle = .flipHorizontal
        present(nextVC!, animated: true, completion: nil)
    }
    
    var sharedWordList:[(english:String, japanese:String, example:String, exAnswer:String)] = []
    
    var answerList:[String] = []
    
    var randomAN = -1
    
    var answered = -2
    
    var points = 0
    
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var memorizeViewEnglishWords: UILabel!
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var answer1: UILabel!
    @IBOutlet weak var answer2: UILabel!
    @IBOutlet weak var answer3: UILabel!
    @IBOutlet weak var answer4: UILabel!
    @IBOutlet weak var radio1: UIButton!
    @IBOutlet weak var radio2: UIButton!
    @IBOutlet weak var radio3: UIButton!
    @IBOutlet weak var radio4: UIButton!
    @IBAction func radio1(_ sender: UIButton) {
        answered = 0
        radio1.setImage(UIImage(named: "radiobutton_on"), for: UIControlState.normal)
        radio2.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio3.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio4.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
    }
    
    @IBAction func radio2(_ sender: UIButton) {
        answered = 1
        radio1.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio2.setImage(UIImage(named: "radiobutton_on"), for: UIControlState.normal)
        radio3.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio4.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
    }
    
    @IBAction func radio3(_ sender: UIButton) {
        answered = 2
        radio1.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio2.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio3.setImage(UIImage(named: "radiobutton_on"), for: UIControlState.normal)
        radio4.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
    }
    
    @IBAction func radio4(_ sender: UIButton) {
        answered = 3
        radio1.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio2.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio3.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio4.setImage(UIImage(named: "radiobutton_on"), for: UIControlState.normal)
    }
    
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        present((self.storyboard?.instantiateViewController(withIdentifier: "Home"))!, animated: false)
    }
    
    @IBOutlet weak var nextButton: UIBarButtonItem! //for isHidden when Quiz is done.
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        guard WordListSingleton.NOWFlag > 0 else {
            memorizeViewEnglishWords.isHidden = true
            question.isHidden = true
            answer1.isHidden = true
            answer2.isHidden = true
            answer3.isHidden = true
            answer4.isHidden = true
            radio1.isHidden = true
            radio2.isHidden = true
            radio3.isHidden = true
            radio4.isHidden = true
            
            nextButton.isEnabled = false
            
            result.text = String(points) + " / " + String(WordListSingleton.NOWFlagB+1)
            result.isHidden = false
            return
        }
        if answered == randomAN {
            points += 1
        }
        randomAN = -1
        answered = -2
        print("POINTS : \(points)")
        radio1.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio2.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio3.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio4.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        
        WordListSingleton.NOWFlag -= 1
        WordListSingleton.randomStartFlag -= 1
        wordListPackShow()
    }
    
    func wordListPackShow() {
        print("sharedWordList: \(sharedWordList.count)")
        print("NOWFlag: \(WordListSingleton.NOWFlag)")
        print("NOWFlagB: \(WordListSingleton.NOWFlagB)")
        print("randomStartFlag : \(WordListSingleton.randomStartFlag)")
        print("randomStartFlagB : \(WordListSingleton.randomStartFlagB)")
        
        memorizeViewEnglishWords.text = sharedWordList[WordListSingleton.randomStartFlag].english
        
        randomAN = Int(arc4random_uniform(UInt32(4)))
        switch randomAN {
        case 0:
            answer1.text = sharedWordList[WordListSingleton.randomStartFlag].japanese
        case 1:
            answer2.text = sharedWordList[WordListSingleton.randomStartFlag].japanese
        case 2:
            answer3.text = sharedWordList[WordListSingleton.randomStartFlag].japanese
        case 3:
            answer4.text = sharedWordList[WordListSingleton.randomStartFlag].japanese
        default:
            print("no answer numbering")
        }
        
        answerList.removeAll()
        for words in sharedWordList {
            answerList.append(words.japanese)
        }
        
        var i = 0
        while i < 4 {
            let randomWrongListIndex = Int(arc4random_uniform(UInt32(WordListSingleton.randomStartFlagB)))
            guard randomWrongListIndex != WordListSingleton.randomStartFlag, answerList[randomWrongListIndex] != "used" else {
                continue
            }
            guard i != randomAN else {
                i += 1
                continue
            }
            switch i {
            case 0 :
                answer1.text = answerList[randomWrongListIndex]
                answerList[randomWrongListIndex] = "used"
            case 1 :
                answer2.text = answerList[randomWrongListIndex]
                answerList[randomWrongListIndex] = "used"
            case 2 :
                answer3.text = answerList[randomWrongListIndex]
                answerList[randomWrongListIndex] = "used"
            case 3 :
                answer4.text = answerList[randomWrongListIndex]
                answerList[randomWrongListIndex] = "used"
            default:
                print("no wrong answer numbering")
            }
            i += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        radio1.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio2.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio3.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        radio4.setImage(UIImage(named: "radiobutton_off"), for: UIControlState.normal)
        
        memorizeViewEnglishWords.isHidden = false
        question.isHidden = false
        answer1.isHidden = false
        answer2.isHidden = false
        answer3.isHidden = false
        answer4.isHidden = false
        radio1.isHidden = false
        radio2.isHidden = false
        radio3.isHidden = false
        radio4.isHidden = false
        nextButton.isEnabled = true
        result.isHidden = true
        
        /**
        sharedNOWFlag = WordListSingleton.sharedInstance.NOWFlag
        sharedNOWFlagB = WordListSingleton.sharedInstance.NOWFlagB
        
        sharedWordList = WordListSingleton.sharedInstance.wordList
        **/
        
        sharedWordList = WordListSingleton.wordList
        WordListSingleton.NOWFlag = WordListSingleton.NOWFlagB
        WordListSingleton.randomStartFlag = WordListSingleton.randomStartFlagB
        wordListPackShow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
