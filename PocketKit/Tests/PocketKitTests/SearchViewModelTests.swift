import XCTest

@testable import PocketKit

class SearchViewModelTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func subject(
    ) -> SearchViewModel {
        SearchViewModel()
    }

    func test_emptyState_forFreeUser_withOnlineSaves_showsSearchEmptyState() {
        let viewModel = subject()
        viewModel.handleEmptyState(.saves)
        XCTAssertTrue(viewModel.emptyState is SearchEmptyState)
    }

    func test_emptyState_forFreeUser_withOnlineArchive_showsSearchEmptyState() {
        let viewModel = subject()
        viewModel.handleEmptyState(.archive)
        XCTAssertTrue(viewModel.emptyState is SearchEmptyState)
    }

    func test_emptyState_forFreeUser_withOnlineAll_showsGetPremiumEmptyState() {
        let viewModel = subject()
        viewModel.handleEmptyState(.all)
        XCTAssertTrue(viewModel.emptyState is GetPremiumEmptyState)
    }

    func test_emptyState_forFreeUser_withNoItems_showsNoResultsEmptyState() {
        let viewModel = subject()
        viewModel.handleEmptyState(.all)
        XCTAssertTrue(viewModel.emptyState is NoResultsEmptyState)
    }
}
