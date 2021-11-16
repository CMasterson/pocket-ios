// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import XCTest
import Sails


class DeleteAnItemTests: XCTestCase {
    var server: Application!
    var app: PocketAppElement!

    func listResponse(_ fixtureName: String = "initial-list") -> Response {
        Response {
            Status.ok
            Fixture.load(name: fixtureName)
                .replacing("MARTICLE", withFixtureNamed: "marticle")
                .data
        }
    }

    func slateResponse() -> Response {
        Response {
            Status.ok
            Fixture.data(name: "slates")
        }
    }

    override func setUpWithError() throws {
        continueAfterFailure = false

        let uiApp = XCUIApplication()
        app = PocketAppElement(app: uiApp)

        server = Application()

        server.routes.post("/graphql") { request, _ in
            let requestBody = body(of: request)

            if requestBody!.contains("getSlateLineup")  {
                return self.slateResponse()
            } else {
                return self.listResponse()
            }
        }

        try server.start()

        app.launch()
    }

    override func tearDownWithError() throws {
        try server.stop()
        app.terminate()
    }

    func test_deletingAnItemFromList_removesItFromList_andSyncsWithServer() {
        app.tabBar.myListButton.wait().tap()

        let itemCell = app
            .userListView
            .itemView(withLabelStartingWith: "Item 2")

        itemCell
            .itemActionButton.wait()
            .tap()

        let expectRequest = expectation(description: "A request to the server")
        var deleteRequestBody: String?
        server.routes.post("/graphql") { request, loop in
            deleteRequestBody = body(of: request)
            expectRequest.fulfill()

            return Response {
                Status.ok
                Fixture.data(name: "delete")
            }
        }

        app.deleteButton.wait().tap()
        app.alert.yes.wait().tap()
        XCTAssertFalse(itemCell.exists)

        wait(for: [expectRequest], timeout: 1)
        guard let requestBody = deleteRequestBody else {
            XCTFail("Expected request body to not be nil")
            return
        }
        XCTAssertTrue(requestBody.contains("deleteSavedItem"))
        XCTAssertTrue(requestBody.contains("item-2"))
    }

    func test_deletingAnItemFromReader_deletesItem_andPopsBackToList() {
        app.tabBar.myListButton.wait().tap()

        let itemCell = app
            .userListView
            .itemView(withLabelStartingWith: "Item 2")
            .wait()

        itemCell.tap()

        let expectRequest = expectation(description: "A request to the server")
        var deleteRequestBody: String?
        server.routes.post("/graphql") { request, loop in
            deleteRequestBody = body(of: request)
            expectRequest.fulfill()

            return Response {
                Status.ok
                Fixture.data(name: "delete")
            }
        }

        app
            .readerView
            .readerToolbar
            .moreButton
            .wait()
            .tap()

        app.deleteButton.wait().tap()
        app.alert.yes.wait().tap()
        wait(for: [expectRequest], timeout: 1)
        guard let requestBody = deleteRequestBody else {
            XCTFail("Expected request body to not be nil")
            return
        }
        XCTAssertTrue(requestBody.contains("deleteSavedItem"))
        XCTAssertTrue(requestBody.contains("item-2"))

        app.userListView.wait()
        XCTAssertFalse(itemCell.exists)
    }
}
