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
    }
    
}
