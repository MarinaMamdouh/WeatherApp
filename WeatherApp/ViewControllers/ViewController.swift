//
//  ViewController.swift
//  WeatherApp
//
//  Created by Marina on 01/07/2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempValueLabel: UILabel!
    @IBOutlet weak var mainTempUnitBtn: UIButton!
    @IBOutlet weak var secondaryTempUnitBtn: UIButton!
    @IBOutlet weak var descriptionIconImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
  
    @IBOutlet weak var searchCityTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    
    let weatherManager = WeatherManager()
    let clManager = CLLocationManager()
    var chosenUnit = WeatherManager.mainTempratureUnit
    var chosenCity = ""
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        weatherManager.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        searchCityTextField.delegate = self
        searchCityTextField.layer.cornerRadius = 20
        searchCityTextField.layer.masksToBounds = true
        
        searchView.layer.shadowColor = UIColor.darkGray.cgColor
        searchView.layer.shadowOpacity = 0.1
        searchView.layer.shadowOffset = CGSize(width: 0, height: 5)
        searchView.layer.shadowRadius = 5
        searchView.layer.cornerRadius = 20
        
        //searchCityTextField.clipsToBounds = true
        
        
        
        // add search image in textfield
        searchCityTextField.leftViewMode = UITextField.ViewMode.always
        searchCityTextField.leftViewMode = .always
        let searchImageView = UIImageView(image: UIImage(named: K.SEARCH_ICON_NAME))
        searchCityTextField.rightView?.addSubview(searchImageView)
        
        clManager.delegate = self
        dateLabel.text = Date().formatDate(format: (chosenUnit == TempratureUnits.Celsius ? K.STANDARD_DATE_FORMATE : K.AMERICAN_DATE_FORMATE))
        clManager.requestWhenInUseAuthorization()
        clManager.requestLocation()
        
    }

    @IBAction func searchBtnClicked(_ sender: Any) {
        if let city = searchCityTextField.text{
            weatherManager.getWeather(for: city, unit: chosenUnit)
            chosenCity = city
            searchCityTextField.text = ""
        }
        searchCityTextField.endEditing(true)
    }
    
    @IBAction func mainTempBtnClicked(_ sender: UIButton) {
        chosenUnit = WeatherManager.mainTempratureUnit
        if chosenCity == ""{
            clManager.requestLocation()
        }else{
            weatherManager.getWeather(for: chosenCity, unit: chosenUnit)
        }
        sender.isEnabled = false
        secondaryTempUnitBtn.isEnabled = true
        sender.setTitleColor(UIColor(named: K.FONT_COLOR_SET), for: .normal)
        secondaryTempUnitBtn.setTitleColor(UIColor.systemGray, for: .normal)
    }
    
    @IBAction func secondaryTempBtnClicked(_ sender: UIButton) {
        self.chosenUnit = WeatherManager.secondTempratureUnit
        sender.isEnabled = false
        self.mainTempUnitBtn.isEnabled = true
        sender.setTitleColor(UIColor(named: K.FONT_COLOR_SET), for: .normal)
        self.mainTempUnitBtn.setTitleColor(UIColor.systemGray, for: .normal)
        if chosenCity == ""{
            clManager.requestLocation()
        }else{
            weatherManager.getWeather(for: chosenCity, unit: chosenUnit)
        }
        
    }
    
    
}

extension ViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if(locations.count > 0){
            manager.stopUpdatingLocation()
            let location = locations.last!
            weatherManager.getWeather(forLocation: location.coordinate.latitude, longitude: location.coordinate.longitude, unit: self.chosenUnit)
            
        }
    }
}

extension ViewController:WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.tempValueLabel.text =  String(format: "%.0f",weather.mainTemprature)
            self.dateLabel.text = Date().formatDate(format: (self.chosenUnit == TempratureUnits.Celsius ? K.STANDARD_DATE_FORMATE : K.AMERICAN_DATE_FORMATE))
            self.descriptionLabel.text = weather.description
            self.humidityLabel.text = "\(weather.humidity)%"
            self.descriptionIconImage.image =  UIImage(named: weather.descriptionIconName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
        if chosenCity != ""{
            chosenCity = ""
        }
    }
    
    
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {        textField.endEditing(true)
        if let city = textField.text{
            weatherManager.getWeather(for: city, unit: chosenUnit)
            chosenCity = city
            searchCityTextField.text = ""
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        searchCityTextField.endEditing(true)
    }
}

