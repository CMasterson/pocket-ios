//
//  ListItem+Constants.swift
//  
//
//  Created by Ky B Hamilton on 12/7/22.
//

import SwiftUI

extension ListItem {
    enum Constants {

        static let verticalPadding: CGFloat = 15
        static let objectSpacing: CGFloat = 10
        
        static let title = Title()
        struct Title {
            let maxLines = 3
            let lineSpacing: CGFloat = 100
            let padding: CGFloat = 8
        }
        
        static let detail = Detail()
        struct Detail {
            let maxLines = 2
            let horizontalSpacing: CGFloat = 10
        }
        
        static let image = Image()
        struct Image {
            let cornerRadius: CGFloat = 4
            let height: CGFloat = 60
            let width: CGFloat = 90
        }
        
        static let tags = Tags()
        struct Tags {
            let padding: CGFloat = 8
            let maxLines = 1
            let horizontalSpacing: CGFloat = 10
            let cornerRadius: CGFloat = 4
            let backgroundColor: Color = Color(.ui.grey7)
            let icon = Icon()
            struct Icon {
                let size: CGFloat = 13
                let color: Color = Color(.ui.grey4)
                let padding: CGFloat = (8 - 2)
            }
        }
        
        static let actionButton = ActionButton()
        struct ActionButton {
            let padding: CGFloat = 4
            let imageSize: CGFloat = 20
        }
    }
}

