//
//  MusicDelegate.swift
//  MusicApp
//
//  Created by Deblina Das on 31/01/18.
//  Copyright © 2018 Deblinas. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: MusicDelegate {
    
    // MARK: Music Delegate
    func refreshFavoriteMusic(with music: Music) {
        clearAllButton.isEnabled = true
        if self.favMusics != nil && self.favMusics.count > 0 {
            isFirstTimeRelaod = false
            // no duplicate entry in favourite music list
            if !isPresent(music: music) { favMusics.append(music)}
        } else {
            favMusics = [Music]()
            favMusics.append(music)
            isFirstTimeRelaod = true
        }
        DispatchQueue.main.async {
            self.favDataSource = FavoriteMusicDataSource(collectionView: self.collectionView, favMusics: self.favMusics, delegate: self)
            self.collectionView.delegate = self.favDataSource
            self.collectionView.dataSource = self.favDataSource
            
            self.collectionView.reloadItems(at: [IndexPath(item: self.favMusics.count - 1, section: 0)])
            if self.isFirstTimeRelaod {
                self.collectionViewHeight.constant = UIScreen.main.bounds.height / 3
                self.view.setNeedsLayout()
            }
        }
    }
}
