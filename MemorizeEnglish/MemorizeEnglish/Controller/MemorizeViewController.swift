//
//  MemorizeViewController.swift
//  MemorizeEnglish
//
//  Created by apple on 2018/08/13.
//  Copyright © 2018年 Chris Rashad Kim. All rights reserved.
//

import UIKit
import RealmSwift

class MemorizeViewController: UIViewController { 
    var timer: Timer?
    
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        present((self.storyboard?.instantiateViewController(withIdentifier: "Home"))!, animated: false)
    }

    @IBAction func quizButton(_ sender: UIButton) {
        WordListSingleton.randomStartFlag = WordListSingleton.randomStartFlagB
        WordListSingleton.NOWFlag = WordListSingleton.NOWFlagB
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        guard WordListSingleton.NOWFlag < WordListSingleton.NOWFlagB else {
            return
        }
        WordListSingleton.randomStartFlag += 1
        WordListSingleton.NOWFlag += 1
        wordListPackShow()
    }
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        guard WordListSingleton.NOWFlag > 0 else {
            return
        }
        WordListSingleton.randomStartFlag -= 1
        WordListSingleton.NOWFlag -= 1
        wordListPackShow()
    }
    
    @IBOutlet weak var memorizeViewJapaneseWords: UILabel!
    
    @IBOutlet weak var memorizeViewEnglishWords: UILabel!
    
    @IBAction func numberOfWords(_ sender: UISegmentedControl) {
        timer!.invalidate()
        switch sender.selectedSegmentIndex {
        case 0:
            print("10個")
            wordListTimer(NOW: 9)
        case 1:
            print("20個")
            guard WordListSingleton.wordList.count >= 20 else {
                registerRequest()
                return
            }
            wordListTimer(NOW: 19)
        case 2:
            print("30個")
            guard WordListSingleton.wordList.count >= 30 else {
                registerRequest()
                return
            }
            wordListTimer(NOW: 29)
        default:
            print("no timer")
        }
    }
    
    func wordListTimer(NOW: Int) {
        var rsf = 9
        while true {
            rsf = Int(arc4random_uniform(UInt32(WordListSingleton.wordList.count)))
            if rsf >= NOW  {
                break
            }
        }
        WordListSingleton.randomStartFlagB = rsf
        WordListSingleton.randomStartFlag = rsf
        WordListSingleton.NOWFlagB = NOW
        WordListSingleton.NOWFlag = NOW
        memorizeViewEnglishWords.text = WordListSingleton.wordList[WordListSingleton.randomStartFlag].english
        memorizeViewJapaneseWords.text = WordListSingleton.wordList[WordListSingleton.randomStartFlag].japanese
        timer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(self.wordListTimerFlag), userInfo: nil, repeats: true)
    }
    
    @objc func wordListTimerFlag() {
        guard WordListSingleton.NOWFlag > 0 else {
            return timer!.invalidate()
        }
        WordListSingleton.randomStartFlag -= 1
        WordListSingleton.NOWFlag -= 1
        wordListPackShow()
    }

    func wordListPackShow() {
        memorizeViewEnglishWords.text = WordListSingleton.wordList[WordListSingleton.randomStartFlag].english
        memorizeViewJapaneseWords.text = WordListSingleton.wordList[WordListSingleton.randomStartFlag].japanese
    }
    
    func wordListPackSet() {
        //DB getter //VO setter
        let realm = try! Realm()
        
        print("realm in ? : \(realm.objects(RealmWordList.self))")
        WordListSingleton.wordList.removeAll()
        for e in realm.objects(RealmWordList.self) {
            WordListSingleton.wordList.append((english: e.english, japanese: e.japanese, example: e.example, exAnswer: e.exAnswer))
        }
        print("wordSingleton in ? : \(WordListSingleton.wordList)")
    }
    
    func registerRequest() {
        let textFieldAlert = UIAlertController(title: "Error", message: "Need to register more words", preferredStyle:  UIAlertControllerStyle.alert)
        let textFieldAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) -> Void in
                self.dismiss(animated: true, completion: nil)
                print("::WorListLackAlert OK")
        }
        textFieldAlert.addAction(textFieldAlertAction)
        present(textFieldAlert, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        guard WordListSingleton.wordList.count >= 10 else {
            let textFieldAlert = UIAlertController(title: "Error", message: "Need more than 10 registered words", preferredStyle: UIAlertControllerStyle.alert)
            let textFieldAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) -> Void in
                self.dismiss(animated: true, completion: nil)
                print("::WordListLackAlert OK")
            }
            textFieldAlert.addAction(textFieldAlertAction)
            present(textFieldAlert, animated: true, completion: nil)
            return
        }
        
        wordListTimer(NOW: 9)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /**
        sharedNOWFlag = WordListSingleton.sharedInstance.NOWFlag
        sharedNOWFlagB = WordListSingleton.sharedInstance.NOWFlagB
        
        sharedWordList = WordListSingleton.sharedInstance.wordList
        **/
        
        wordListPackSet()
        
        print("WordListSingleton.wordList: \(WordListSingleton.wordList.count)")
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
