//
//  WeatherLoader.swift
//  IosTest
//
//  Created by Chiang Chih-Yi on 2018/1/26.
//  Copyright © 2018年 Test. All rights reserved.
//

import Foundation
import Kanna
import Alamofire

class WeatherLoader {
    
    static let sharedInstance = WeatherLoader()
    private init() {}
    
    var storageDelegate: StorageDelegate?
    
    func setStorageDelegate(storageDelegate: StorageDelegate) {
        self.storageDelegate = storageDelegate
    }
    
    func getWeekWeather(weatherLoaderDelegate: WeatherLoaderDelegate) {
        Alamofire.request("http://www.cwb.gov.tw/rss/forecast/36_08.xml").responseData {
            response in
            
            var weathers = [String]()
            
            do {
                if let xml = response.result.value {
                    let doc = try Kanna.XML(xml: xml, encoding: String.Encoding.utf8)
                    
                    for description in doc.xpath("//description") {
                        if (description.text?.contains("白天"))! && (description.text?.contains("晚上"))! {
                            let weather = description.text!.replacingOccurrences(of: "Optional(\"", with: "").replacingOccurrences(of: "\")", with: "").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                            
                            let tempWeathers = weather.components(separatedBy: "<BR>")
                            
                            for i in stride(from: 0, to: tempWeathers.count-1, by: 2) {
                                weathers.append("\(tempWeathers[i].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))\n\(tempWeathers[i+1].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))")
                            }
                        }
                    }
                }
            }
            catch {
                print("error...")
            }
            
            self.storageDelegate?.refreshWeather(weathers: weathers, weatherLoaderDelegate: weatherLoaderDelegate)
        }
    }
    
}
