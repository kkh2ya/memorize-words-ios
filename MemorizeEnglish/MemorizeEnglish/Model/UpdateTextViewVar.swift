//
//  UpdateTextViewVar.swift
//  MemorizeEnglish
//
//  Created by apple on 2018/09/02.
//  Copyright © 2018年 Chris Rashad Kim. All rights reserved.
//

import UIKit

class UpdateTextViewVar: NSObject {
    static var englishTextVar:String?
    static var japaneseTextVar:String?
    static var exampleTextVar:String?
    static var exAnswerTextVar:String?
    static func textFill(english:String, japanese:String, example:String, exAnswer:String) {
        englishTextVar = english
        japaneseTextVar = japanese
        exampleTextVar = example
        exAnswerTextVar = exAnswer
    }
}
