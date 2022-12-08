//
//  OverfolowMenu.swift
//  
//
//  Created by Ky B Hamilton on 12/7/22.
//

import SwiftUI
import Textile

struct OverflowMenu: View {
    
    var overflowActions: [ItemAction]
    var trackOverflow: ItemAction? = nil
    var image: ImageAsset = .overflow
    var trailingPadding: Bool = false
    
    var body: some View {
        if overflowActions != [] {
            Menu {
                    ForEach(overflowActions, id: \.self){ action in
                        Button {
                            action.handler?{}
                        } label: {
                            HStack(alignment: .center) {
                                Text(action.title)
                                Spacer()
                                if let image = action.image {
                                    Image(uiImage: image)
                                        .accessibilityIdentifier(action.accessibilityIdentifier)
                                }
                            }
                        }
                    }
                
            } label: {
                Image(asset: image)
                    .actionButtonStyle(selected: false, trailingPadding: trailingPadding)
                    .accessibilityIdentifier("More Actions")
                
            }.onTapGesture {
                if let trackOverflow = trackOverflow {
                    trackOverflow.handler?{}
                }
            }
        }
    }
}
