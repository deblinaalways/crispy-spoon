//
//  FavCollectionViewCell.swift
//  MusicApp
//
//  Created by Deblina Das on 24/01/18.
//  Copyright © 2018 Deblinas. All rights reserved.
//

import UIKit

class FavCollectionViewCell: UICollectionViewCell {
    var favMusic: Music!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var title: UILabel!
    
    func configure(with favMusic: Music) {
        self.favMusic = favMusic
        self.imageView.image = #imageLiteral(resourceName: "Place Holder")
        reloadImage()
        self.title.text = self.favMusic.title!
    }
    
    func reloadImage() {
        if let url = favMusic.imageUrl {
            activityIndicator.startAnimating()
            getData(from: url, completion: { (imageData, response, error) in
                guard let imageData = imageData, error == nil  else  {
                    DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = UIImage(data: imageData)
                }
            })
        } else {
            // Image Load failed
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
}
