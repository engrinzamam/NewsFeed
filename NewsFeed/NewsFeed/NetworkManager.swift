//
//  NetworkManager.swift
//  NewsFeed
//
//  Created by Sixlogics on 19/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
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
    
    static func getNews(for country: String, completion: @escaping (JSON) -> Void) {
        let apiKey = "d1100591b9054c3da2fef23e4c9a2a15"
        let baseURL = "https://newsapi.org/v2/top-headlines?country="
        let params : [String : String] = ["apiKey" : apiKey]
        let finalURL = baseURL + "\(country)"
        
        AF.request(finalURL, method: .get, parameters: params).response { response in
            switch response.result{
            case .success(let value):
                print("Success! Got the News Feed")
                let json = JSON(value!)
                print(json)
                completion(json)
            case .failure(let error):
                print("Merror is----\(error.localizedDescription)")
            }
        }
    }
    
    
    //        AF.request("https://newsapi.org/v2/top-headlines",
       //        method: .get,
       //        parameters: ["myKey1": "myValue1"],
       //        encoding: JSONEncoding.default,
       //        headers: self.authHeader).responseJSON { response in
       //             //your response
       //        }
       
       
       
       //        AF.request("https://newsapi.org/v2/top-headlines?country=us&apiKey=01a15b77a38740d0baa2d9db003ea001").responseJSON{
       //            response in
       //
       //            switch response.result{
       //            case .success(let value):
       //                print("Success! Got the News data")
       //                let json = JSON(arrayLiteral: value)
       //                print(json)
       //            case .failure(let error):
       //                print(error.localizedDescription)
       //            }
       //        }
    
    
    func urlSessionCall() {
        
        let baseURLString = "https://newsapi.org/"
        var urlComponent = URLComponents(string: baseURLString)
        urlComponent?.path = "/v2/top-headlines"
        
        urlComponent?.queryItems = queryItems
        if let finalURL = urlComponent?.url {
            let urlRequest = URLRequest(url: finalURL)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlRequest) { (data,response,error) in
                guard error == nil else {
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let json = try? JSON(data: data)
                    print("Success! Got the News data")
                    print(json)
                    
                } catch(let error) {
                    print("Found Error is:--- \(error.localizedDescription)")
                    
                }
                
            }
            task.resume()
        }
    }
}

var queryItems:[URLQueryItem] {
       var quertyItems = [URLQueryItem]()
       let firstQueryItem = URLQueryItem(name: "country", value: "us")
       let secondQueryItem = URLQueryItem(name: "apiKey", value: "01a15b77a38740d0baa2d9db003ea001")
       quertyItems.append(firstQueryItem)
       quertyItems.append(secondQueryItem)
       return quertyItems
   }


