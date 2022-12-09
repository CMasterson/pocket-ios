import SwiftUI
import Textile

struct SearchView: View {
    @ObservedObject
    var viewModel: SearchViewModel

    var body: some View {
        Results(viewModel: viewModel)
//        if viewModel.showRecentSearches == true, !viewModel.recentSearches.isEmpty {
//            RecentSearchView(recentSearches: viewModel.recentSearches)
//        } else if let emptyState = viewModel.emptyState {
//            EmptyStateView(viewModel: emptyState)
//                .padding(Margins.normal.rawValue)
//        }
    }
}

struct Results: View {
    @ObservedObject
    var viewModel: SearchViewModel

    var listItemViewModel: ItemsListItemCell.Model = ItemsListItemCell.Model(
        attributedTitle: NSAttributedString(string: "This is the title lorem ipsum dolor sit amet"),
        attributedDetail: NSAttributedString(string: "Detail Details Daily"),
        attributedTags: [NSAttributedString(string: "Tag 1"), NSAttributedString(string: "Tag 2")],
        attributedTagCount: NSAttributedString(string: "+3"),
        thumbnailURL: URL(string: "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true"),
        shareAction: ItemAction.share{_ in print("Share button tapped!") },
        favoriteAction: ItemAction.favorite{_ in print("Favorite button tapped!")},
        overflowActions: [ItemAction.addTags{_ in print("Add tags button tapped!")}, ItemAction.archive{_ in print("Archive button tapped!")}, ItemAction.delete{_ in print("Delete button tapped!")}],
        filterByTagAction: nil,
        trackOverflow: nil,
        swiftUITrackOverflow: ItemAction(title: "", identifier: UIAction.Identifier(rawValue: ""), accessibilityIdentifier: "", image: nil, handler: {_ in
            print("Overflow button tapped!")
        })
    )

    var listItemViewModelOneTag: ItemsListItemCell.Model = ItemsListItemCell.Model(
        attributedTitle: NSAttributedString(string: "This is the title lorem ipsum dolor sit amet"),
        attributedDetail: NSAttributedString(string: "Detail Details Daily"),
        attributedTags: [NSAttributedString(string: "Tag 1")],
        attributedTagCount: nil,
        thumbnailURL: URL(string: "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true"),
        shareAction: ItemAction.share{_ in print("Share button tapped!") },
        favoriteAction: ItemAction.favorite{_ in print("Favorite button tapped!")},
        overflowActions: [ItemAction.addTags{_ in print("Add tags button tapped!")}, ItemAction.archive{_ in print("Archive button tapped!")}, ItemAction.delete{_ in print("Delete button tapped!")}],
        filterByTagAction: nil,
        trackOverflow: nil,
        swiftUITrackOverflow: ItemAction(title: "", identifier: UIAction.Identifier(rawValue: ""), accessibilityIdentifier: "", image: nil, handler: {_ in
            print("Overflow button tapped!")
        })
    )

    var listItemViewModelNoTag: ItemsListItemCell.Model = ItemsListItemCell.Model(
        attributedTitle: NSAttributedString(string: "This is the title lorem ipsum dolor sit amet"),
        attributedDetail: NSAttributedString(string: "Detail Details Daily"),
        attributedTags: nil,
        attributedTagCount: nil,
        thumbnailURL: URL(string: "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true"),
        shareAction: ItemAction.share{_ in print("Share button tapped!") },
        favoriteAction: ItemAction.favorite{_ in print("Favorite button tapped!")},
        overflowActions: [ItemAction.addTags{_ in print("Add tags button tapped!")}, ItemAction.archive{_ in print("Archive button tapped!")}, ItemAction.delete{_ in print("Delete button tapped!")}],
        filterByTagAction: nil,
        trackOverflow: nil,
        swiftUITrackOverflow: ItemAction(title: "", identifier: UIAction.Identifier(rawValue: ""), accessibilityIdentifier: "", image: nil, handler: {_ in
            print("Overflow button tapped!")
        })
    )

    var body: some View {
        NavigationView {
            List() {
                // only renders cell if view
                ListItem(model: listItemViewModelNoTag)
                ListItem(model: listItemViewModel)
                ListItem(model: listItemViewModelOneTag)
                ListItem(model: listItemViewModelNoTag)
                ListItem(model: listItemViewModelNoTag)



                ForEach(1..<10) {_ in
                    ListItem(model: listItemViewModel)
                }
            }.listStyle(.plain)
        }
    }
}

struct RecentSearchView: View {
    var recentSearches: [String]

    var body: some View {
        List {
            Section(header: Text("Recent Searches").style(.search.header)) {
                ForEach(recentSearches.reversed(), id: \.self) { recentSearch in
                    HStack {
                        Text(recentSearch)
                            .style(.search.row.default)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        // TODO: Handle recent search tap
                    }
                }
            }
        }
        .listStyle(.plain)
        .accessibilityIdentifier("recent-searches")
    }
}
