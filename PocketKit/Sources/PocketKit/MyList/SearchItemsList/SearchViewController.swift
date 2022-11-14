//
//  File.swift
//  
//
//  Created by Timothy Choh on 11/9/22.
//

import SwiftUI

class SearchViewController: UIViewController {
    let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    func setUpNavBar() {
        searchBar.sizeToFit()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        navigationItem.searchController?.searchBar.scopeButtonTitles = ["Saves", "Archived", "All"]
        navigationItem.searchController?.searchBar.showsScopeBar = true
        navigationItem.titleView = searchBar
        searchBar.isTranslucent = true
    }
}
