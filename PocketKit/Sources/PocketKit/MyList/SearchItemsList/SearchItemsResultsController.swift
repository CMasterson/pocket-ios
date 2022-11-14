//
//  File.swift
//  
//
//  Created by Timothy Choh on 11/2/22.
//

import SwiftUI
import UIKit

struct SearchItems <ViewModel: ItemsListViewModel>: UIViewControllerRepresentable {
    let searchBar = UISearchBar()

    typealias UIViewControllerType = Wrapper

    func makeCoordinator() -> Coordinator {
        Coordinator(representable: self)
    }

    func makeUIViewController(context: Context) -> Wrapper {
        Wrapper()
    }

    func updateUIViewController(_ wrapper: Wrapper, context: Context) {
        wrapper.searchController = context.coordinator.searchController
    }

    class Coordinator: NSObject {
        let representable: SearchItems

        let searchController: UISearchController

        init(representable: SearchItems) {
            self.representable = representable
            self.searchController = UISearchController(searchResultsController: nil)
            super.init()
        }
    }

    class Wrapper: UIViewController {
        var searchController: UISearchController? {
            get {
                self.parent?.navigationItem.searchController
            }
            set {
                self.parent?.navigationItem.searchController = newValue
            }
        }
    }
}
