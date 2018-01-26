//
//  WordLoader.swift
//  IosTest
//
//  Created by Chiang Chih-Yi on 2018/1/26.
//  Copyright © 2018年 Test. All rights reserved.
//

import Foundation

class WordLoader {
    
    static let sharedInstance = WordLoader()
    private init() {}
    
    var storageDelegate: StorageDelegate?
    
    func setStorageDelegate(storageDelegate: StorageDelegate) {
        self.storageDelegate = storageDelegate
    }
    
    func getDailyWord(wordLoaderDelegate: WordLoaderDelegate) {
        storageDelegate?.refreshWord(word: "test", wordLoaderDelegate: wordLoaderDelegate)
        
        let myURLString = "http://www.appledaily.com.tw/index/dailyquote/"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            print("HTML : \(myHTMLString)")
        } catch let error {
            print("Error: \(error)")
        }
    }
    
}
