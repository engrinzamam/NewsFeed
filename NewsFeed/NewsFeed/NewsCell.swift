//
//  NewsCell.swift
//  NewsFeed
//
//  Created by Sixlogics on 19/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var linkLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var loadingBar: UIActivityIndicatorView!
    
    let cache = NSCache<NSString, UIImage>()
    
    var news: News! {
        didSet {
            self.titleNews.text = news.title
            self.linkLbl.text = news.url
            self.authorLbl.text = "Author's: \(news.author)"
            
            DispatchQueue.main.async {
                self.loadingBar.startAnimating()
                self.downloadImage(from: self.news.urlToImage) { image in
                
                    DispatchQueue.main.async {
                        self.loadingBar.stopAnimating()
                        self.loadingBar.isHidden = true
                        guard image != nil else {
                            self.imageNews.image = UIImage(named: "noImage")
                            return
                        }
                        self.imageNews.image = image
                    }
                    
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension NewsCell {
    
    
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard  let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data,
                    let image = UIImage(data: data) else {
                        completed(nil)
                        return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}
