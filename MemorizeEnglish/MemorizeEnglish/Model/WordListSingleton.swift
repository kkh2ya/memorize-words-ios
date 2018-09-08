//
//  WordListSingleton.swift
//  MemorizeEnglish
//
//  Created by apple on 2018/08/14.
//  Copyright © 2018年 Chris Rashad Kim. All rights reserved.
//

import UIKit

class WordListSingleton: NSObject {
    static var randomStartFlagB = 9
    static var randomStartFlag = 9
    
    static var NOWFlagB = 9
    static var NOWFlag = 9
    
    static var wordList:[(english:String, japanese:String, example:String, exAnswer:String)] = []
    
    // currently not in use
    static let sharedInstance = WordListSingleton()
    private override init() {}
}
