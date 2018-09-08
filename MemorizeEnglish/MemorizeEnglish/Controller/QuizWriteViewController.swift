//
//  QuizWriteViewController.swift
//  MemorizeEnglish
//
//  Created by apple on 2018/08/13.
//  Copyright © 2018年 Chris Rashad Kim. All rights reserved.
//

import UIKit

class QuizWriteViewController: UIViewController {
    
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
    
    var points = 0
    
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var memorizeViewJapaneseWords: UILabel!
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var answer: UITextField!
    
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        present((self.storyboard?.instantiateViewController(withIdentifier: "Home"))!, animated: false)
    }
    
    @IBOutlet weak var nextButton: UIBarButtonItem! //for isHidden when Quiz is done.
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        guard WordListSingleton.NOWFlag > 0 else {
            memorizeViewJapaneseWords.isHidden = true
            question.isHidden = true
            answer.isHidden = true
            
            nextButton.isEnabled = false
            
            result.text = String(points) + " / " + String(WordListSingleton.NOWFlagB+1)
            result.isHidden = false
            return
        }
        print("answerTEXT: \(answer.text ?? "")")
        if answer.text ?? "" == WordListSingleton.wordList[WordListSingleton.randomStartFlag].english {
            points += 1
        }
        print("POINTS : \(points)")
        WordListSingleton.NOWFlag -= 1
        WordListSingleton.randomStartFlag -= 1
        wordListPackShow()
    }
    
    func wordListPackShow() {
        answer.text = ""
        memorizeViewJapaneseWords.text = WordListSingleton.wordList[WordListSingleton.randomStartFlag].japanese
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        answer.text = ""
        
        memorizeViewJapaneseWords.isHidden = false
        question.isHidden = false
        answer.isHidden = false
        nextButton.isEnabled = true
        result.isHidden = true
  
        /**
        sharedNOWFlag = WordListSingleton.sharedInstance.NOWFlag
        sharedNOWFlagB = WordListSingleton.sharedInstance.NOWFlagB
        
        sharedWordList = WordListSingleton.sharedInstance.wordList
        **/
        
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
