//
//  ViewController.swift
//  IosTest
//
//  Created by Chiang Chih-Yi on 2018/1/26.
//  Copyright © 2018年 Test. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WordLoaderDelegate, WeatherLoaderDelegate {

    let storageDelegate = UIApplication.shared.delegate as! StorageDelegate
    
    @IBOutlet var wordBtn: UIButton!
    
    @IBOutlet var weatherBtn: UIButton!
    
    @IBOutlet var wordLabel: UILabel!
    
    @IBOutlet var weatherTableView: UITableView!
    
    var weathers: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initView()
    }
    
    func initView() {
        // UITableView
        weatherTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        weatherTableView.separatorInset = UIEdgeInsets.zero
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(_:)))
        longPressRecognizer.minimumPressDuration = 0.5
        self.weatherTableView.addGestureRecognizer(longPressRecognizer)
        
        refreshWordView()
        refreshWeatherView()
    }

    func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.weatherTableView)
            if let indexPath = weatherTableView.indexPathForRow(at: touchPoint) {
                print("longPress:\(indexPath.row)")
                
                let alertController = UIAlertController(
                    title: "刪除此筆資料?",
                    message: nil,
                    preferredStyle: .alert)
                
                let yesAction = UIAlertAction(
                    title: "Yes",
                    style: .default,
                    handler: {
                        (action: UIAlertAction!) -> Void in
                        
                        self.weathers.remove(at: indexPath.row)
                        self.weatherTableView.deleteRows(at: [indexPath], with: .automatic)
                        
                        self.storageDelegate.refreshWeather(weathers: self.weathers, weatherLoaderDelegate: nil);
                })
                alertController.addAction(yesAction)
                
                let noAction = UIAlertAction(
                    title: "No",
                    style: .default,
                    handler: {
                        (action: UIAlertAction!) -> Void in
                })
                alertController.addAction(noAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        if let weatherLabel = cell.textLabel {
            weatherLabel.text = "\(weathers[indexPath.row])"
        }
            
        return cell
    }

    @IBAction func wordBtnClick(_ sender: UIButton) {
        sender.isEnabled = false;
        sender.alpha = 0.5
        
        WordLoader.sharedInstance.getDailyWord(wordLoaderDelegate: self)
    }

    @IBAction func weatherBtnClick(_ sender: UIButton) {
        sender.isEnabled = false;
        sender.alpha = 0.5
        
        WeatherLoader.sharedInstance.getWeekWeather(weatherLoaderDelegate: self)
    }
    
    
    // WordLoaderDelegate functions
    func refreshWordView() {
        let word: String? = storageDelegate.getWord()
        
        if word != nil && word != wordLabel.text {
            wordLabel.text = word
            
            print("Word refresh:\(word ?? "每日一字")")
        }
        
        if !wordBtn.isEnabled {
            wordBtn.isEnabled = true;
            wordBtn.alpha = 1.0
        }
    }
    
    // WeatherLoaderDelegate functions
    func refreshWeatherView() {
        let tempWeathers: [String]? = storageDelegate.getWeather()
        
        if tempWeathers != nil {
            weathers = tempWeathers!
            
            weatherTableView.reloadData()
        }
        
        if !weatherBtn.isEnabled {
            weatherBtn.isEnabled = true;
            weatherBtn.alpha = 1.0
        }
    }
    
}

