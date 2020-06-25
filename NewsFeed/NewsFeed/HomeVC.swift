//
//  HomeVC.swift
//  NewsFeed
//
//  Created by Sixlogics on 19/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//


//https://github.com/bonny17/newsJSON

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var cityPickerView: UIPickerView!
    @IBOutlet weak var searchNewsButton: UIButton!

    
    var country = [Country]()
    var countryShortName = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchNewsButton.isHidden = true
        self.searchNewsButton.layer.cornerRadius = 18
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveCountries()
        self.cityPickerView.dataSource = self
        self.cityPickerView.delegate = self
    }
    
    func saveCountries() {
        self.country = [Country(countryName: "ARGENTINA", countryShortName: "ar"),
                        Country(countryName: "AUSTRIA", countryShortName: "at"),
                        Country(countryName: "AUSTRALIA", countryShortName: "au"),
                        Country(countryName: "BELGIO", countryShortName: "be"),
                        Country(countryName: "BULGARIA", countryShortName: "bg"),
                        Country(countryName: "BRASILE", countryShortName: "br"),
                        Country(countryName: "CANADA", countryShortName: "ca"),
                        Country(countryName: "CINA", countryShortName: "cn"),
                        Country(countryName: "CUBA", countryShortName: "cu"),
                        Country(countryName: "FRANCIA", countryShortName: "fr"),
                        Country(countryName: "HONG KONG", countryShortName: "hk"),
                        Country(countryName: "INDIA", countryShortName: "in"),
                        Country(countryName: "RUSSIA", countryShortName: "ru"),
                        Country(countryName: "TAILANDIA", countryShortName: "th"),
                        Country(countryName: "EMIRATI ARABI UNITI", countryShortName: "ae")
        ]
    }
    
    func goToNews(name: String) {
        if let newsVC = storyboard?.instantiateViewController(identifier: "NewsVC") as? NewsVC {
            if countryShortName != "" {
                newsVC.selectedCountryName = countryShortName
                self.navigationController?.pushViewController(newsVC, animated: true)
            }
        }
    }
    
    @IBAction func searchNewsTapped(_ sender: UIButton) {
        self.goToNews(name: countryShortName)
    }

}

extension HomeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.country.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.country[row].countryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCountryShortName = self.country[row].countryShortName
        self.countryShortName = selectedCountryShortName
        self.searchNewsButton.isHidden = false
        print(countryShortName)
    }
}

struct Country {
    let countryName: String
    let countryShortName: String
}
