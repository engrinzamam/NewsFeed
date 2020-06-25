//
//  NewsVC.swift
//  NewsFeed
//
//  Created by Sixlogics on 19/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SafariServices

class NewsVC: UIViewController {

    @IBOutlet weak var tableViewNews: UITableView!
    var news:[News] = []
    var selectedCountryName = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadNews(countryName: selectedCountryName)
//        self.getJSON(forCity: "us")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewNews.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        self.tableViewNews.delegate = self
        self.tableViewNews.dataSource = self
    }

    func loadNews(countryName: String) {
        NetworkManager.getNews(for: countryName) { jsonNews in
            guard let articles = jsonNews["articles"].array else { return }
            articles.forEach { article in
                let news = News(json: article)
                self.news.append(news)
            }
            DispatchQueue.main.async {
                self.tableViewNews.reloadData()
            }
        }
    }
}


extension NewsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell {
            let news = self.news[indexPath.row]
            cell.news = news
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = self.news[indexPath.row].url
        if let url = URL(string: urlString) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.preferredControlTintColor  = .systemGreen
            present(safariVC, animated: true)
        }
    }
}




extension NewsVC {
    func getJSON(forCity inizialeCitta: String?){
        let APP_ID = "d1100591b9054c3da2fef23e4c9a2a15"
        let MY_URL = "https://newsapi.org/v2/top-headlines?country="
        let params : [String : String] = ["apiKey" : APP_ID]
        parseJSON(forURL:MY_URL + inizialeCitta!,withParameters: params)
        
    }
    
    func parseJSON(forURL url: String?,withParameters parameters: [String:String]){
        
        AF.request(url!, method: .get, parameters:parameters).responseJSON {
            response in
            
            switch response.result{
            case .success(let value):
                print("Success! Got the News data")
                let json = JSON(arrayLiteral: value)
                print("Result is:---\(json)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
