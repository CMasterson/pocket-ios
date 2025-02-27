import Foundation
import UIKit

enum Margins: CGFloat {
  case thin = 8
  case normal = 16
  case wide = 32
}

enum StyleConstants {
    static let thumbnailSize = CGSize(width: 90, height: 60)
    static let carouselHeight: CGFloat = 146
    static var groupHeight: CGFloat {
        return min(UIFontMetrics.default.scaledValue(for: carouselHeight), 300)
    }
}
