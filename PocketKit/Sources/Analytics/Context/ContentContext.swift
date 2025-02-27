// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation

public struct ContentContext: Context {
    public static let schema = "iglu:com.pocket/content/jsonschema/1-0-0"

    let url: URL

    public init(url: URL) {
        self.url = url
    }
}
