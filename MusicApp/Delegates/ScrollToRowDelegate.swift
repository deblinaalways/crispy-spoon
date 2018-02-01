//
//  ScrollToRowDelegate.swift
//  MusicApp
//
//  Created by Deblina Das on 31/01/18.
//  Copyright © 2018 Deblinas. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: ScrollToRowDelegate {
    
    // MARK: Scroll To Row Delegate
    func scrollToRow(music: Music, position: UITableViewScrollPosition, animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: music.id, section: 0), at: position, animated: animated)
        }
    }
}
