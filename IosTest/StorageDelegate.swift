//
//  StorageDelegate.swift
//  IosTest
//
//  Created by Chiang Chih-Yi on 2018/1/26.
//  Copyright © 2018年 Test. All rights reserved.
//

import Foundation

protocol StorageDelegate {
    
    func refreshWord(word: String?, wordLoaderDelegate: WordLoaderDelegate?)
    func getWord() -> String?
    
    func refreshWeather(weathers: [String]?, weatherLoaderDelegate: WeatherLoaderDelegate?)
    func getWeather() -> [String]?
    
}
