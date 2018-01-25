//
//  StorageDelegate.swift
//  IosTest
//
//  Created by Chiang Chih-Yi on 2018/1/26.
//  Copyright © 2018年 Test. All rights reserved.
//

import Foundation

protocol StorageDelegate {
    
    mutating func refreshWord(word: String?)
    mutating func getWord() -> String?
    
    mutating func refreshWeather(weathers: [String]?)
    mutating func getWeather() -> [String]?
    
}
