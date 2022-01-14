// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import XCTest


struct UserListElement: PocketUIElement {
    let element: XCUIElement

    init(_ element: XCUIElement) {
        self.element = element
    }

    var itemCells: XCUIElementQuery {
        element.cells.matching(NSPredicate(format: "identifier = %@", "my-list-item"))
    }

    var favoritesButton: XCUIElement {
        element.cells.matching(
            NSPredicate(
                format: "identifier = %@",
                "topic-chip"
            )
        ).containing(.staticText, identifier: "Favorites").element(boundBy: 0)
    }

    var itemCount: Int {
        itemCells.count
    }

    func itemView(at index: Int) -> ItemRowElement {
        return ItemRowElement(itemCells.element(boundBy: index))
    }

    func itemView(withLabelStartingWith string: String) -> ItemRowElement {
        let cell = itemCells.containing(
            .staticText,
            identifier: string
        ).element(boundBy: 0)

        return ItemRowElement(cell)
    }

    func pullToRefresh() {
        let centerCenter = CGVector(dx: 0.5, dy: 0.8)

        itemCells
            .element(boundBy: 0)
            .coordinate(withNormalizedOffset: centerCenter)
            .press(
                forDuration: 0.1,
                thenDragTo: element.coordinate(
                    withNormalizedOffset: centerCenter
                )
            )
    }
}
