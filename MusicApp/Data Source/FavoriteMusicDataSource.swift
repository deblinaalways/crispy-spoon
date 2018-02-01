//
//  FavoriteMusicDataSource.swift
//  MusicApp
//
//  Created by Deblina Das on 31/01/18.
//  Copyright © 2018 Deblinas. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMusicDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var favMusics: [Music]!
    var delegate: ScrollToRowDelegate!
    
    init(collectionView: UICollectionView, favMusics: [Music], delegate: ScrollToRowDelegate) {
        self.collectionView = collectionView
        self.favMusics = favMusics
        self.delegate = delegate
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favMusics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! FavCollectionViewCell
        cell.configure(with: favMusics[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.collectionView.bounds.width / 3
        let height = self.collectionView.bounds.width / 3
        let constrainedSize = CGSize(width: width, height: height)
        return constrainedSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.scrollToRow(music: favMusics[indexPath.row], position: UITableViewScrollPosition.top, animated: true)
    }
    
}
