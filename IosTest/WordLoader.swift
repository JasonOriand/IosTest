//
//  WordLoader.swift
//  IosTest
//
//  Created by Chiang Chih-Yi on 2018/1/26.
//  Copyright © 2018年 Test. All rights reserved.
//

import Foundation
import Kanna
import Alamofire

class WordLoader {
    
    static let sharedInstance = WordLoader()
    private init() {}
    
    var storageDelegate: StorageDelegate?
    
    func setStorageDelegate(storageDelegate: StorageDelegate) {
        self.storageDelegate = storageDelegate
    }
    
    func getDailyWord(wordLoaderDelegate: WordLoaderDelegate) {
        Alamofire.request("http://www.appledaily.com.tw/index/dailyquote/").responseString {
            response in
            
            var dailyWord: String?
            
            do {
                if let html = response.result.value {
                    let doc = try Kanna.HTML(html: html, encoding: String.Encoding.utf8)
                    
                    let content = doc.css("article[class=dphs]")[0]
                    
                    dailyWord = content.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                }
            }
            catch {
                print("error...")
            }
            
            self.storageDelegate?.refreshWord(word: dailyWord, wordLoaderDelegate: wordLoaderDelegate);
        }
    }
    
}
