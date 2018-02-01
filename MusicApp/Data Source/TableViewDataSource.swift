//
//  TableViewDataSource.swift
//  MusicApp
//
//  Created by Deblina Das on 31/01/18.
//  Copyright © 2018 Deblinas. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource, MusicPlayedDelegate {
    var musics: [Music]!
    var tableView: UITableView!
    var delegate: MusicDelegate!
    var isSearchEnabled: Bool!
    
    init(musics: [Music], tableView: UITableView, delegate: MusicDelegate, isSearchEnabled: Bool) {
        self.musics = musics
        self.tableView = tableView
        self.delegate = delegate
        self.isSearchEnabled = isSearchEnabled
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let cell1 = self.tableView.dequeueReusableCell(withIdentifier: "filterCell") as! FilterTableViewCell
        !isSearchEnabled ? cell.configureCell(with: musics[indexPath.row], resetDelegate: self, indexPath: indexPath) : cell1.configureCell(with: musics[indexPath.row])
        
        return !isSearchEnabled ? cell: cell1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.refreshFavoriteMusic(with: musics[indexPath.row])
    }
    
    // MARK: Music Played Delegate
    func resetMusicPlayButton(music: Music, indexPath: IndexPath) {
        var _music = music
        _music.isPlaying = music.isPlaying == true ? false : true
        let musicCount = self.musics.count
        var indexPaths = [IndexPath]()
        for index in 0...musicCount - 1 {
            if indexPath.row != index {
                musics[index].isPlaying = false
                indexPaths.append(IndexPath(row: index, section: 0))
            } else {
                musics[index].isPlaying = true
            }
        }
        if indexPaths.count > 0 {
            indexPaths.forEach {
                let cell = self.tableView.cellForRow(at: $0) as? TableViewCell
                if let cell = cell { cell.resetMusicPlayButton(music: _music) }
            }
        }
        
    }
}
