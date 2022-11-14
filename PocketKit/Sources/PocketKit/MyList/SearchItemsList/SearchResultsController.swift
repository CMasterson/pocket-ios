import UIKit
import Combine

class SearchResultsController: UIViewController {
    private let model: SearchViewModel

    private lazy var layoutConfiguration = UICollectionViewCompositionalLayout { [weak self] index, env in
        return self?.section(for: index, environment: env)
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<SearchViewModel.Section, SearchViewModel.Cell> = {
        UICollectionViewDiffableDataSource<SearchViewModel.Section, SearchViewModel.Cell>(
            collectionView: collectionView
        ) { [weak self] (collectionView, indexPath, viewModelCell) -> UICollectionViewCell? in
            return self?.cell(for: viewModelCell, at: indexPath)
        }
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutConfiguration)
        return collectionView
    }()

    private var subscriptions: [AnyCancellable] = []

    init(
        model: SearchViewModel
    ) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.register(cellClass: EmptyStateCollectionViewCell.self)

        model.$snapshot.receive(on: DispatchQueue.main).sink { [weak self] snapshot in
            self?.dataSource.apply(snapshot)
        }.store(in: &subscriptions)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = UIColor(.ui.apricot1)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func cell(
        for viewModelCell: SearchViewModel.Cell,
        at indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch viewModelCell {
        case .emptyState:
            let cell: EmptyStateCollectionViewCell = collectionView.dequeueCell(for: indexPath)

            guard let viewModel = model.emptyState else {
                return cell
            }

            cell.configure(parent: self, viewModel)
            return cell
        }
    }

    func section(for index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let section = self.dataSource.sectionIdentifier(for: index)
        switch section {
        case .emptyState:
            let section = NSCollectionLayoutSection(
                group: .vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(0.65)
                    ),
                    subitems: [
                        .init(
                            layoutSize: .init(
                                widthDimension: .fractionalWidth(1),
                                heightDimension: .fractionalHeight(1)
                            )
                        )
                    ]
                )
            )
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            return section
        default:
            return .empty()
        }
    }
}

extension SearchResultsController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
      guard let scopeTitles = searchBar.scopeButtonTitles else { return }

      model.selectedScope = SearchScope(rawValue: scopeTitles[selectedScope])

//    let category = Candy.Category(rawValue:
//      searchBar.scopeButtonTitles![selectedScope])
//    filterContentForSearchText(searchBar.text!, category: category)
  }
}
extension SearchResultsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let cell = dataSource.itemIdentifier(for: indexPath) else {
//            return
//        }
//        model.willDisplay(cell, at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = dataSource.itemIdentifier(for: indexPath) else {
//            return
//        }
//
//        model.select(cell: cell, at: indexPath)
    }
}
