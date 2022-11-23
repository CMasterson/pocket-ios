import Foundation
import SwiftUI

public enum Status: String {
    case premium = "premium"
    case free = "free"
    case unknown = "unknown"
}

public protocol User {
    func setPremiumStatus(_ isPremium: Bool)
    func setId(_ id: String)

    func getId() -> String?

    func clear()
}

public class PocketUser: User {
    static let userStatusKey = "User.statusKey"
    static let userIdKey = "User.idKey"

    @AppStorage
    public var status: Status?

    @AppStorage
    public var id: String?

    public init(status: Status = .unknown, userDefaults: UserDefaults) {
        _status = AppStorage(Self.userStatusKey, store: userDefaults)
        _id = AppStorage(Self.userIdKey, store: userDefaults)
    }

    public func setPremiumStatus(_ isPremium: Bool) {
        status = isPremium ? .premium : .free
    }

    public func setId(_ id: String) {
        self.id = id
    }

    public func getId() -> String? {
        return id
    }
    
    public func clear() {
        status = .unknown
        id = nil
    }
}
