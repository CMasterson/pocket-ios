import Foundation
import UIKit
import Combine
import Sync

protocol HomeRefreshCoordinatorProtocol {
    func refresh(isForced: Bool, _ completion: @escaping () -> Void)
}

class HomeRefreshCoordinator: HomeRefreshCoordinatorProtocol {
    static let dateLastRefreshKey = "HomeRefreshCoordinator.dateLastRefreshKey"
    private let notificationCenter: NotificationCenter
    private let userDefaults: UserDefaults
    private let source: Source
    private let minimumRefreshInterval: TimeInterval
    private var subscriptions: [AnyCancellable] = []
    private var isRefreshing: Bool = false

    init(notificationCenter: NotificationCenter, userDefaults: UserDefaults, source: Source, minimumRefreshInterval: TimeInterval = 12 * 60 * 60) {
        self.userDefaults = userDefaults
        self.notificationCenter = notificationCenter
        self.minimumRefreshInterval = minimumRefreshInterval
        self.source = source

        self.notificationCenter.publisher(for: UIScene.willEnterForegroundNotification, object: nil).sink { [weak self] _ in
            self?.refresh { }
        }.store(in: &subscriptions)
    }

    func refresh(isForced: Bool = false, _ completion: @escaping () -> Void) {
        if shouldRefresh(isForced: isForced), !isRefreshing {
            Task {
                do {
                    isRefreshing = true
                    try await source.fetchSlateLineup(HomeViewModel.lineupIdentifier)
                    userDefaults.setValue(Date(), forKey: Self.dateLastRefreshKey)
                    Crashlogger.breadcrumb(category: "refresh", level: .info, message: "Home Refresh Occur")
                } catch {
                    Crashlogger.capture(error: error)
                }
                completion()
                isRefreshing = false
            }
        }
    }

    private func shouldRefresh(isForced: Bool = false) -> Bool {
        guard let lastActiveTimestamp = userDefaults.object(forKey: Self.dateLastRefreshKey) as? Date else {
            return true
        }

        let timeSinceLastRefresh = Date().timeIntervalSince(lastActiveTimestamp)

        return timeSinceLastRefresh >= minimumRefreshInterval || isForced
    }
}
