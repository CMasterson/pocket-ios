import UIKit
import Sync
import SwiftUI
import Combine
import SafariServices
import Analytics

class RootCoordinator {
    private var window: UIWindow?

    private var main: MainCoordinator?
    private var loggedOutCoordinator: LoggedOutCoordinator?
    private var shouldAnimateTransition = false

    private var subscriptions: [AnyCancellable] = []
    private var bannerView: UIView?

    private let rootViewModel: RootViewModel
    private let mainCoordinatorFactory: () -> MainCoordinator
    private let loggedOutCoordinatorFactory: () -> LoggedOutCoordinator

    init(
        rootViewModel: RootViewModel,
        mainCoordinatorFactory: @escaping () -> MainCoordinator,
        loggedOutCoordinatorFactory: @escaping () -> LoggedOutCoordinator
    ) {
        self.rootViewModel = rootViewModel
        self.mainCoordinatorFactory = mainCoordinatorFactory
        self.loggedOutCoordinatorFactory = loggedOutCoordinatorFactory
    }

    func setup(scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        window = UIWindow(windowScene: windowScene)

        rootViewModel.$isLoggedIn.sink { isLoggedIn in
            self.updateState(isLoggedIn)
        }.store(in: &subscriptions)

        window?.makeKeyAndVisible()

        rootViewModel.$bannerViewModel.receive(on: DispatchQueue.main).sink { [weak self] viewModel in
            if let viewModel = viewModel {
                self?.setupBanner(with: viewModel)
            } else {
                self?.dismissView()
            }
        }.store(in: &subscriptions)
    }

    private func setupBanner(with viewModel: BannerViewModel) {
        let bannerView = BannerView()
        bannerView.configure(model: viewModel)

        window?.addSubview(bannerView)
        configureConstraints(bannerView)

        let tabBarHeight: CGFloat = main?.tabBar?.frame.height ?? 0
        let translation = window?.traitCollection.userInterfaceIdiom == .phone ? tabBarHeight : 0

        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
            bannerView.transform = CGAffineTransform(translationX: 0, y: -translation - 12)
        })

        self.bannerView = bannerView
    }

    private func removeBanner() {
        bannerView?.removeFromSuperview()
        bannerView = nil
    }

    private func configureConstraints(_ bannerView: UIView) {
        guard let window = window else { return }
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        if window.traitCollection.userInterfaceIdiom == .pad {
            NSLayoutConstraint.activate([
                bannerView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -12),
                bannerView.widthAnchor.constraint(equalToConstant: 600),
                bannerView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            ])
        } else {
            let bottomAnchor = main?.tabBar?.bottomAnchor ?? window.safeAreaLayoutGuide.bottomAnchor
            NSLayoutConstraint.activate([
                bannerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
                bannerView.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 12),
                bannerView.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -12),
            ])
        }
    }

    func dismissView() {
        let animationDistance = self.window?.frame.height
        UIView.animate(
            withDuration: 1.0,
            delay: 0,
            options: [.allowUserInteraction],
            animations: { [weak self] in
                self?.bannerView?.transform = CGAffineTransform(translationX: 0, y: animationDistance ?? CGFloat.greatestFiniteMagnitude)
            }, completion: { [weak self] _ in
                self?.removeBanner()
            }
        )
    }

    private func updateState(_ isLoggedIn: Bool) {
        if isLoggedIn {
            loggedOutCoordinator = nil
            main = mainCoordinatorFactory()

            transition(to: main?.viewController) { [weak self] in
                self?.main?.showInitialView()
            }
        } else {
            main = nil
            loggedOutCoordinator = loggedOutCoordinatorFactory()

            transition(to: loggedOutCoordinator?.viewController)
        }

        if !self.shouldAnimateTransition {
            self.shouldAnimateTransition = true
        }
    }

    private func transition(
        to rootViewController: UIViewController?,
        completion: (() -> Void)? = nil
    ) {
        func transition() {
            UIView.transition(
                with: window!,
                duration: 0.25,
                options: .transitionCrossDissolve,
                animations: {
                    self.window?.rootViewController = rootViewController
                },
                completion: { _ in
                    completion?()
                }
            )
        }

        if shouldAnimateTransition {
            transition()
        } else {
            UIView.performWithoutAnimation {
                transition()
            }
        }
    }
}
