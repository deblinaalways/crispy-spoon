//
//  TableViewCell.swift
//  MusicApp
//
//  Created by Deblina Das on 24/01/18.
//  Copyright © 2018 Deblinas. All rights reserved.
//

import UIKit


class TableViewCell: UITableViewCell {

    @IBOutlet var musicImageView: UIImageView!
    @IBOutlet var songTitle: UILabel!
    @IBOutlet var artistName: UILabel!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private(set) var music: Music!
    var isPlaying: Bool = false
    var resetDelegate: MusicPlayedDelegate!
    var indexPath: IndexPath!
    
    func configureCell(with music: Music, resetDelegate: MusicPlayedDelegate, indexPath: IndexPath) {
        self.music = music
        
        self.resetDelegate = resetDelegate
        self.indexPath = indexPath
        self.musicImageView.image = #imageLiteral(resourceName: "Place Holder")
        reloadImage()
        self.songTitle.text = self.music.title!
        self.artistName.text = self.music.artistName!
        if self.music.isPlaying == true {
            playButton.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
            self.isPlaying = true
        } else {
            playButton.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
            self.isPlaying = false
        }
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
                    self.musicImageView.image = UIImage(data: imageData)
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

    @IBAction func playButtonTapped(_ sender: UIButton) {
        if isPlaying == false {
            self.isPlaying = true
            self.music.isPlaying = true
            playButton.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
            self.resetDelegate.resetMusicPlayButton(music: self.music, indexPath: self.indexPath)
        } else if isPlaying == true {
            self.isPlaying = false
            self.music.isPlaying = false
            playButton.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
            self.resetDelegate.resetMusicPlayButton(music: self.music, indexPath: self.indexPath)
        }
    }
    
    func resetMusicPlayButton(music: Music) {
        DispatchQueue.main.async {
            if music.isPlaying == true {
                self.playButton.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
                self.isPlaying = true
            } else {
                self.playButton.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
                self.isPlaying = false
            }
        }
    }
}
