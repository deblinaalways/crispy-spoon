//
//  Protocol.swift
//  MusicApp
//
//  Created by Deblina Das on 31/01/18.
//  Copyright © 2018 Deblinas. All rights reserved.
//

import Foundation
import UIKit

protocol MusicDelegate {
    func refreshFavoriteMusic(with music: Music)
}

protocol ScrollToRowDelegate {
    func scrollToRow(music: Music, position: UITableViewScrollPosition, animated: Bool)
}

protocol MusicPlayedDelegate {
    func resetMusicPlayButton(music: Music, indexPath: IndexPath)
}
