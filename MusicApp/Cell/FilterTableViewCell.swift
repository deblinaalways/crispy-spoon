//
//  FilterTableViewCell.swift
//  MusicApp
//
//  Created by Deblina Das on 31/01/18.
//  Copyright © 2018 Deblinas. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var songimage: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var artist: UILabel!
    
    
    
    
    var music: Music!
    
    func configureCell(with music: Music) {
        self.music = music
        reloadImage()
        self.title.text = self.music.title!
        self.artist.text = self.music.artistName!
    }
    
    func reloadImage() {
        if let url = music.imageUrl {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            getData(from: url, completion: { (imageData, response, error) in
                guard let imageData = imageData, error == nil  else  {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                    }
                    return }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.songimage.image = UIImage(data: imageData)
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
