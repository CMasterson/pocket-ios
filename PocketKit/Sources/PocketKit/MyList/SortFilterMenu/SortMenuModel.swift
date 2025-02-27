import Foundation

enum SortSection: String, Hashable, CaseIterable {
    case sortBy = "Sort by"
}

enum SortOption: String, Hashable {
    case newest = "Newest saved"
    case oldest = "Oldest saved"
    case shortestToRead = "Shortest to read"
    case longestToRead = "Longest to read"
}
