//
//  ListViewController.swift
//  MemorizeEnglish
//
//  Created by apple on 2018/08/15.
//  Copyright © 2018年 Chris Rashad Kim. All rights reserved.
//

import UIKit
import RealmSwift

class WordListCell: UITableViewCell {
    
    var onDeleteButtonTapped: (() -> Void)? = nil
    var onUpdateButtonTapped: (() -> Void)? = nil
    
    @IBOutlet weak var wordsInCell: UILabel!
    @IBOutlet weak var meaningInCell: UILabel!
    @IBOutlet weak var exampleInCell: UILabel!
    @IBOutlet weak var answerInCell: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    @IBAction func deleteButton(_ sender: UIButton) {
        // DB Delete //error management
        if let onDBT = onDeleteButtonTapped {
            onDBT()
        }
    }
    
    @IBAction func updateButton(_ sender: UIButton) {
        // use method in RegisterViewController for DB Update
        if let onUBT = onUpdateButtonTapped {
            onUBT()
        }
    }
}

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var englishList:[String]=[] //use for Search
    
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        present((self.storyboard?.instantiateViewController(withIdentifier: "Home"))!, animated: false)
    }

    @IBAction func regOrList(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Register")
            UpdateTextViewVar.textFill(english: "", japanese: "", example: "", exAnswer: "")
            nextRegOrList(id: "Register")
        case 1:
            print("List")
            nextRegOrList(id: "List")
        default:
            print("no regOrList")
        }
    }
        
    @IBAction func searchText(_ sender: UITextField) {
        if let findIndex = englishList.index(of: sender.text!) {
            wordListTable.selectRow(at: IndexPath(row: findIndex, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.middle)
        }
    }
    
    func nextRegOrList(id: String) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: id)
        present(nextVC!, animated: false, completion: nil)
    }
    
    @IBOutlet weak var wordListTable: UITableView!
    
    var wordListFromDB:[(english:String, japanese:String, example:String, exAnswer:String)] = []

    func wordListDBGet() {
        // DB Read //error management
        let realm = try! Realm()
        let allWordList = realm.objects(RealmWordList.self)
        wordListFromDB.removeAll()
        for e in allWordList {
            wordListFromDB.append((english: e.english, japanese: e.japanese, example: e.example, exAnswer: e.exAnswer))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordListFromDB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wordListCell = tableView.dequeueReusableCell(withIdentifier: "WordListCell", for: indexPath) as! WordListCell
        wordListCell.wordsInCell.text = wordListFromDB[indexPath.row].english
        wordListCell.meaningInCell.text = wordListFromDB[indexPath.row].japanese
        wordListCell.exampleInCell.text = wordListFromDB[indexPath.row].example
        wordListCell.answerInCell.text = wordListFromDB[indexPath.row].exAnswer
        
        wordListCell.onDeleteButtonTapped = {
            let realm = try! Realm()
            let deleteWordList = realm.objects(RealmWordList.self).filter("english like '\(self.wordListFromDB[indexPath.row].english)'")
            deleteWordList.forEach { dwl in
                try! realm.write {
                    realm.delete(dwl)
                }
            }
            self.wordListDBGet()
            self.wordListTable.reloadData()
        }
        
        wordListCell.onUpdateButtonTapped = {
            UpdateTextViewVar.textFill(english: self.wordListFromDB[indexPath.row].english, japanese: self.wordListFromDB[indexPath.row].japanese, example: self.wordListFromDB[indexPath.row].example, exAnswer: self.wordListFromDB[indexPath.row].exAnswer)
            
            self.nextRegOrList(id: "Register")
        }
        
        return wordListCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        wordListDBGet()
        
        for words in wordListFromDB {
            englishList.append(words.english)
        }
        
        wordListTable.reloadData()
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
