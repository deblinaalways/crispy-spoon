//
//  ViewController.swift
//  MusicApp
//
//  Created by Deblina Das on 24/01/18.
//  Copyright © 2018 Deblinas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet var clearAllButton: UIBarButtonItem!
    
    var musics: [Music]!
    var favMusics: [Music]!
    var dataSource: TableViewDataSource!
    var favDataSource: FavoriteMusicDataSource!
    var isFirstTimeRelaod = false
    var searchController: UISearchController!
    var isSearchEnabled: Bool = false
    
    // MARK: Factory Method
    class func navigate() -> UINavigationController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Helvetica Bold", size: 30)!, NSAttributedStringKey.foregroundColor: UIColor(red: 0, green: 181/255.0, blue: 60/255.0, alpha: 1.0) ]
        self.title = "Music"
        configureSearchController()
        clearAllButton.isEnabled = false
        constructMusicFiles()
        configureTableViewDataSource(with: self.musics, isSearchEnabled: false)
    }
    
    func configureSearchController() {
        self.searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.scopeButtonTitles = [SearchScope.artistName.rawValue, SearchScope.songTitle.rawValue]
            controller.searchBar.placeholder = "Search"
            controller.searchBar.showsCancelButton = false
            controller.searchBar.delegate = self
            controller.searchBar.barTintColor = UIColor.white
            controller.searchBar.tintColor = UIColor.white
            controller.searchBar.barStyle = .blackTranslucent
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            self.navigationItem.hidesSearchBarWhenScrolling = false
            self.navigationItem.searchController = controller
            return controller
        })()
    }
    
    func configureTableViewDataSource(with musics: [Music], isSearchEnabled: Bool) {
        self.isSearchEnabled = isSearchEnabled
        self.dataSource = TableViewDataSource(musics: musics, tableView: self.tableView, delegate: self, isSearchEnabled: isSearchEnabled)
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
        self.tableView.reloadData()
    }
    
    func constructMusicFiles() {
        musics = [Music]()
        for (index, title) in titles.enumerated() {
            var music = Music()
            music.id = index
            music.title = title
            music.artistName = artistsNames[index]
            if let url = URL(string: imageURLStrings[index]) {
                music.imageUrl = url
            }
            music.lengthSize = 6.0
            musics.append(music)
        }
    }

    func isPresent(music: Music) -> Bool {
        let musics = favMusics.filter { _music -> Bool in
            return _music.id == music.id
        }
        return !musics.isEmpty
    }
    
    @IBAction func clearAllFavMusicButtonTapped(_ sender: UIBarButtonItem) {
        favMusics.removeAll()
        self.isFirstTimeRelaod = false
        DispatchQueue.main.async {
            self.clearAllButton.isEnabled = false
            self.collectionViewHeight.constant = 0.0001
            self.view.setNeedsLayout()
        }
    }
    
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            // scroll to row
            print(searchText)
            guard let scopeString = searchController.searchBar.scopeButtonTitles?[searchController.searchBar.selectedScopeButtonIndex] else { return }
            print(scopeString)
            if scopeString == SearchScope.artistName.rawValue {
                let filteredList = self.musics.filter({ music -> Bool in
                    let isMatching = music.artistName!.lowercased().contains(searchText.lowercased())
                    return isMatching
                })
                configureTableViewDataSource(with: filteredList, isSearchEnabled: true)
                print(filteredList)
            } else {
                let filteredList = self.musics.filter({ music -> Bool in
                    let isMatching = music.title!.lowercased().contains(searchText.lowercased())
                    return isMatching
                })
                configureTableViewDataSource(with: filteredList, isSearchEnabled: true)
                print(filteredList)
            }
        } else {
            isSearchEnabled = false
            constructMusicFiles()
            configureTableViewDataSource(with: self.musics, isSearchEnabled: false)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.isSearchEnabled = false
        constructMusicFiles()
        configureTableViewDataSource(with: self.musics, isSearchEnabled: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print(selectedScope)
    }
}

enum SearchScope: String {
    case artistName = "Artist Name"
    case songTitle  = "Song Title"
}







