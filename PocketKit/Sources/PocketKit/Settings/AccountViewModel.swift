import Sync
import Analytics
import Textile
import Foundation
import SharedPocketKit
import SwiftUI

class AccountViewModel: ObservableObject {
    private let appSession: AppSession

    init(appSession: AppSession) {
        self.appSession = appSession
    }

    func signOut() {
        appSession.currentSession = nil
    }

    @Published var isPresentingHelp = false
    @Published var isPresentingTerms = false
    @Published var isPresentingPrivacy = false
}
