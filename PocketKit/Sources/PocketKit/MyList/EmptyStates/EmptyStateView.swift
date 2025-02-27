import SwiftUI
import Textile

open class SwiftUICollectionViewCell<Content>: UICollectionViewCell where Content: View {
    private(set) var host: UIHostingController<Content>?

    func embed(in parent: UIViewController, withView content: Content) {
        if let host = self.host {
            host.rootView = content
            host.view.layoutIfNeeded()
        } else {
            let host = UIHostingController(rootView: content)
            parent.addChild(host)
            host.didMove(toParent: parent)
            self.contentView.addSubview(host.view)
            self.host = host
        }
    }

    deinit {
        host?.willMove(toParent: nil)
        host?.view.removeFromSuperview()
        host?.removeFromParent()
        host = nil
    }
}

class EmptyStateCollectionViewCell: SwiftUICollectionViewCell<EmptyStateView> {
    func configure(parent: UIViewController, _ viewModel: EmptyStateViewModel) {
        embed(in: parent, withView: EmptyStateView(viewModel: viewModel))
        host?.view.frame = self.contentView.bounds
        host?.view.backgroundColor = .clear
        host?.view.accessibilityIdentifier = viewModel.accessibilityIdentifier
    }
}

struct EmptyStateView: View {
    private var viewModel: EmptyStateViewModel

    @State
    private var showSafariView = false

    static let maxWidth: CGFloat = 300

    init(viewModel: EmptyStateViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .center, spacing: 35) {
            Image(asset: viewModel.imageAsset)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: Self.maxWidth)

            VStack(alignment: .center, spacing: 20) {
                Text(viewModel.headline).style(.main)

                if let subtitle = viewModel.detailText {
                    if let icon = viewModel.icon {
                        VStack(alignment: .center, spacing: 5) {
                            Image(asset: icon)
                            Text(subtitle).style(.detail)
                        }
                    } else { Text(subtitle).style(.detail) }
                }

                if let buttonText = viewModel.buttonText, let webURL = viewModel.webURL {
                    Button(action: {
                        self.showSafariView = true
                    }, label: {
                        Text(buttonText).style(.buttonLabel)
                            .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                            .frame(maxWidth: 320)
                    }).buttonStyle(ActionsPrimaryButtonStyle())
                    .sheet(isPresented: self.$showSafariView) {
                        SFSafariView(url: webURL)
                    }
                }
            }
        }
    }
}

private extension Style {
    static let main: Self = .header.sansSerif.h2.with(weight: .bold).with { $0.with(alignment: .center).with(lineSpacing: 6) }
    static let detail: Self = .header.sansSerif.p2.with { $0.with(alignment: .center).with(lineSpacing: 6) }
    static let buttonLabel: Self = .header.sansSerif.h7.with(color: .ui.white)
}
