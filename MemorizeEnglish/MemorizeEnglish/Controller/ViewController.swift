//
//  ViewController.swift
//  MemorizeEnglish
//
//  Created by apple on 2018/08/13.
//  Copyright © 2018年 Chris Rashad Kim. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //sample data DB insert (10 wordLists)
        
//        if RealmWordList.sampleDataFlag == 0 {
//            RealmWordList.sampleDataFlag += 1
        
            //let realm = try! Realm()
            
            /** //truncate RealmWordList table in DB
            try! realm.write {
                let allWordList = realm.objects(RealmWordList.self)
                realm.delete(allWordList)
            }
            **/
            
            /**
            let realmWordList1 = RealmWordList()
            realmWordList1.english = "apple"
            realmWordList1.japanese = "リンゴ"
            realmWordList1.example = "Bite on apple"
            realmWordList1.exAnswer = "apple"
            
            try! realm.write {
                realm.add(realmWordList1)
            }
            
            let realmWordList2 = RealmWordList()
            
            realmWordList2.english = "purple"
            realmWordList2.japanese = "紫"
            realmWordList2.example = "String is purple"
            realmWordList2.exAnswer = "purple"
            
            try! realm.write {
                realm.add(realmWordList2)
            }
            
            let realmWordList3 = RealmWordList()
            
            realmWordList3.english = "play"
            realmWordList3.japanese = "遊ぶ"
            realmWordList3.example = "Coding is playing"
            realmWordList3.exAnswer = "playing"
            
            try! realm.write {
                realm.add(realmWordList3)
            }
            
            let realmWordList4 = RealmWordList()
            
            realmWordList4.english = "peace"
            realmWordList4.japanese = "平和"
            realmWordList4.example = "Let there be peace"
            realmWordList4.exAnswer = "peace"
            
            try! realm.write {
                realm.add(realmWordList4)
            }
            
            let realmWordList5 = RealmWordList()
            
            realmWordList5.english = "see"
            realmWordList5.japanese = "見る"
            realmWordList5.example = "I see you"
            realmWordList5.exAnswer = "see"
            
            try! realm.write {
                realm.add(realmWordList5)
            }
            
            let realmWordList6 = RealmWordList()
            
            realmWordList6.english = "hit"
            realmWordList6.japanese = "打つ"
            realmWordList6.example = "Hit the spot"
            realmWordList6.exAnswer = "Hit"
            
            try! realm.write {
                realm.add(realmWordList6)
            }
            
            let realmWordList7 = RealmWordList()
            
            realmWordList7.english = "delegate"
            realmWordList7.japanese = "与える"
            realmWordList7.example = "I delegated the task to sales team"
            realmWordList7.exAnswer = "delegated"
            
            try! realm.write {
                realm.add(realmWordList7)
            }
            
            let realmWordList8 = RealmWordList()
            
            realmWordList8.english = "go"
            realmWordList8.japanese = "行く"
            realmWordList8.example = "I went to work"
            realmWordList8.exAnswer = "went"
            
            try! realm.write {
                realm.add(realmWordList8)
            }
            
            let realmWordList9 = RealmWordList()
            
            realmWordList9.english = "make"
            realmWordList9.japanese = "作る"
            realmWordList9.example = "We made some change"
            realmWordList9.exAnswer = "made"
            
            try! realm.write {
                realm.add(realmWordList9)
            }
            
            let realmWordList10 = RealmWordList()
            
            realmWordList10.english = "want"
            realmWordList10.japanese = "欲しい"
            realmWordList10.example = "I want it desperately"
            realmWordList10.exAnswer = "want"
            
            try! realm.write {
                realm.add(realmWordList10)
            }
            **/
//        }
        
        UpdateTextViewVar.textFill(english: "", japanese: "", example: "", exAnswer: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

