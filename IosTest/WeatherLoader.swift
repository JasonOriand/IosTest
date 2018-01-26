//
//  WeatherLoader.swift
//  IosTest
//
//  Created by Chiang Chih-Yi on 2018/1/26.
//  Copyright © 2018年 Test. All rights reserved.
//

import Foundation

class WeatherLoader {
    
    static let sharedInstance = WeatherLoader()
    private init() {}
    
    var storageDelegate: StorageDelegate?
    
    func setStorageDelegate(storageDelegate: StorageDelegate) {
        self.storageDelegate = storageDelegate
    }
    
    func getWeekWeather(weatherLoaderDelegate: WeatherLoaderDelegate) {
        storageDelegate?.refreshWeather(weathers: ["天氣1", "天氣2", "天氣3", "天氣4", "天氣5", "天氣6", "天氣7"], weatherLoaderDelegate: weatherLoaderDelegate)
    }
    
}
