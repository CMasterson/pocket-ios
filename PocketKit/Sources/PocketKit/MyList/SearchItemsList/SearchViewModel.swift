import CoreData
import UIKit
import Combine

enum SearchScope: String, CaseIterable {
    case saves = "Saves"
    case archive = "Archive"
    case all = "All Items"
}

class SearchViewModel {
    typealias ItemIdentifier = NSManagedObjectID
    var items: [String] = []

    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cell>

    @Published
    var snapshot: Snapshot

    private var subscriptions: [AnyCancellable] = []

    @Published
    var selectedScope: SearchScope?

    @Published
    var emptyState: EmptyStateViewModel? = SearchEmptyState()

    var scopeTitles: [String] {
        SearchScope.allCases.map { $0.rawValue }
    }

    init() {
        self.snapshot = Self.loadingSnapshot()

        $selectedScope.sink { [weak self] selectedScope in
            guard let selectedScope else { return }
            self?.handleEmptyState(selectedScope)
        }.store(in: &subscriptions)

    }

    func handleEmptyState(_ scope: SearchScope) {
        guard items.isEmpty else {
            return
        }
        switch scope {
        case .saves, .archive:
            emptyState = SearchEmptyState()
        case .all:
            // and use is not premium else SearchEmptyStateViewModel
            emptyState = GetPremiumEmptyState()
        }
        snapshot.reloadSections([.emptyState])
    }

    static func loadingSnapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.emptyState])
        snapshot.appendItems([.emptyState], toSection: .emptyState)
        return snapshot
    }

}

extension SearchViewModel {
    enum Section: Hashable {
        case emptyState
    }

    enum Cell: Hashable {
        case emptyState
    }
}
