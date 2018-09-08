//
//  RealmWordList.swift
//  MemorizeEnglish
//
//  Created by apple on 2018/09/04.
//  Copyright © 2018年 Chris Rashad Kim. All rights reserved.
//

import UIKit
import RealmSwift

class RealmWordList: Object {
    @objc dynamic var english = ""
    @objc dynamic var japanese = ""
    @objc dynamic var example = ""
    @objc dynamic var exAnswer = ""
    static var sampleDataFlag = 0
}
