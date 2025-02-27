import Foundation

public enum SaveServiceStatus {
    case existingItem(SavedItem)
    case newItem(SavedItem)
    case taggedItem(SavedItem)

    var savedItem: SavedItem {
        switch self {
        case .existingItem(let savedItem), .newItem(let savedItem), .taggedItem(let savedItem):
            return savedItem
        }
    }
}

public protocol SaveService {
    func save(url: URL) -> SaveServiceStatus
    func retrieveTags(excluding tags: [String]) -> [Tag]?
    func addTags(savedItem: SavedItem, tags: [String]) -> SaveServiceStatus
}
