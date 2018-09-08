//
//  RegisterViewController.swift
//  MemorizeEnglish
//
//  Created by apple on 2018/08/15.
//  Copyright © 2018年 Chris Rashad Kim. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {
        
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        present((self.storyboard?.instantiateViewController(withIdentifier: "Home"))!, animated: false)
    }
    
    @IBAction func regOrList(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Register")
            nextRegOrList(id: "Register")
        case 1:
            print("List")
            nextRegOrList(id: "List")
        default:
            print("no regOrList")
        }
    }
    
    func nextRegOrList(id: String) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: id)
        present(nextVC!, animated: false, completion: nil)
    }
    
    var wordListForDB:(english:String, japanese:String, example:String, exAnswer:String)?
    
    @IBOutlet weak var englishText: UITextField?
    @IBOutlet weak var japaneseText: UITextField?
    @IBOutlet weak var exampleText: UITextField?
    @IBOutlet weak var exAnswerText: UITextField?
    
    @IBAction func uploadButton(_ sender: UIBarButtonItem) {
        wordListDBSet()
    }
    
    func wordListDBSet() {
        let englishT = englishText?.text
        let japaneseT = japaneseText?.text
        let exampleT = exampleText?.text
        let exAnswerT = exAnswerText?.text
        guard englishT != "", japaneseT != "", exampleT != "", exAnswerT != "" else {
            let textFieldAlert = UIAlertController(title: "Error", message: "Fill in the textfield", preferredStyle: UIAlertControllerStyle.alert)
            let textFieldAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) -> Void in
                print("WLDBtextFieldAlert OK")
            }
            textFieldAlert.addAction(textFieldAlertAction)
            present(textFieldAlert, animated: true, completion: nil)
            return
        }
        
        wordListForDB = (english:englishT!, japanese:japaneseT!, example:exampleT!, exAnswer:exAnswerT!)
        
        print("englishT! \(englishT!)")
        print("wordListForDB!.english ::: \(wordListForDB!.english)")
        print("wordListForDB!.example ::: \(wordListForDB!.example)")
        
        //DB Create or Update (Conditional SQL) // error management
        let realm = try! Realm()
        
        let updateWordList = realm.objects(RealmWordList.self).filter("english like '\(wordListForDB!.english)'")
        if updateWordList.count != 0 {
            updateWordList.forEach { uwl in
                try! realm.write {
                    uwl.japanese = wordListForDB!.japanese
                    uwl.example = wordListForDB!.example
                    uwl.exAnswer = wordListForDB!.exAnswer
                }
            }
        }else{
            let realmWordList = RealmWordList()
            realmWordList.english = wordListForDB!.english
            realmWordList.japanese = wordListForDB!.japanese
            realmWordList.example = wordListForDB!.example
            realmWordList.exAnswer = wordListForDB!.exAnswer
            
            try! realm.write {
                realm.add(realmWordList)
            }
        }
        
        nextRegOrList(id: "List")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        englishText?.text = UpdateTextViewVar.englishTextVar
        japaneseText?.text = UpdateTextViewVar.japaneseTextVar
        exampleText?.text = UpdateTextViewVar.exampleTextVar
        exAnswerText?.text = UpdateTextViewVar.exAnswerTextVar
        if UpdateTextViewVar.englishTextVar != "" {
            englishText?.isEnabled = false
        }else{
            englishText?.isEnabled = true
        }
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
