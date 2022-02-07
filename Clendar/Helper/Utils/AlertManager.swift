//
//  AlertManager.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

extension UIAlertController {
	/// If top most controller is `UIAlertController`, then dismiss it and show.
	/// Else, we show the alert normally.
	func dismissAndShow() {
		func _present(_ controller: UIAlertController) {
			UINavigationController.topViewController?.present(controller, animated: true, completion: nil)
		}

		guard AlertManager.shouldShowAlert else { return }
		if let alert = UINavigationController.topViewController as? UIAlertController {
			alert.safeDismiss {
				_present(alert)
			}
		}
		else {
			_present(self)
		}
	}
}

enum AlertManager {
	/// Attempt not to show overlapped alert instances
	static var shouldShowAlert: Bool {
		UINavigationController.topViewController is UIAlertController == false
	}

	/// Show action sheet
	///
	/// - Parameters:
	///   - title: the title string
	///   - message: the message string
	///   - actionTitle: the action title string
	///   - okAction: the completion handler to execute when user tap on "OK"
	///   - onCancel: the completion handler to execute when user tap on "Cancel"
    static func showActionSheet(onView: UIView? = UIViewController.topViewController?.view, title: String? = nil, message: String = "", actionTitle: String = "", showDelete: Bool = false, deleteTitle: String = "Delete", okAction: VoidBlock? = nil, deleteAction: VoidBlock? = nil, onCancel: VoidBlock? = nil) {

		DispatchQueue.main.async {
			guard shouldShowAlert else { return }
            genLightHaptic()

			let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
			let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { _ in
				onCancel?()
			}

			alertController.addAction(cancelAction)

			if actionTitle.isEmpty == false {
				let openAction = UIAlertAction(title: actionTitle, style: .default) { _ in
					okAction?()
				}
				alertController.addAction(openAction)
			}

			if showDelete {
				let delete = UIAlertAction(title: deleteTitle, style: .destructive) { _ in
					deleteAction?()
				}
				alertController.addAction(delete)
			}

            if let presenter = alertController.popoverPresentationController {
                presenter.permittedArrowDirections = .init(rawValue: 0)
                presenter.sourceView = onView
                presenter.sourceRect = CGRect(x: onView?.bounds.midX ?? 0, y: onView?.bounds.midY ?? 0, width: 0, height: 0)
            }

			UINavigationController.topViewController?.present(alertController, animated: true, completion: nil)
		}
	}

	/// Show action sheet
	///
	/// - Parameters:
	///   - title: the title string
	///   - message: the message string
	///   - actionTitle: the action title string
	///   - okAction: the completion handler to execute when user tap on "OK"
	static func showActionSheet(title: String? = nil, message: String, actionTitle: String, okAction: VoidBlock? = nil) {
		showActionSheet(title: title, message: message, actionTitle: actionTitle, okAction: okAction, onCancel: nil)
	}

    /// Show OK only alert
    ///
    /// - Parameters:
    ///   - title: the title string
    ///   - message: the message string
    ///   - okAction: the completion handler to execute when user tap on "OK"
    static func show(title: String? = nil, message: String, okAction: VoidBlock? = nil) {
        DispatchQueue.main.async {
            guard shouldShowAlert else { return }
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { _ in
                okAction?()
            }

            alertController.addAction(okAction)
            alertController.dismissAndShow()
        }
    }

    /// Show error alert
    /// - Parameters:
    ///   - error: ClendarError instance that conforms to LocalizedError protocol
    ///   - okAction: optional action
    static func showWithError(_ error: Error, okAction: VoidBlock? = nil) {
        DispatchQueue.main.async {
            guard shouldShowAlert else { return }
            let alertController = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { _ in
                okAction?()
            }

            alertController.addAction(okAction)
            alertController.dismissAndShow()
        }
    }

	/// General showing Settings alert constuctor
	///
	/// - Parameters:
	///   - title: the title string
	///   - message: the message string
	///   - onCancel: completion handler to be executed when user tap on cancel
	static func showSettingsAlert(title: String? = nil, message: String, onCancel: VoidBlock? = nil) {
		showActionSheet(title: title, message: message, actionTitle: NSLocalizedString("Settings", comment: ""), okAction: {
			_ = URL(string: UIApplication.openSettingsURLString).flatMap { UIApplication.shared.open($0, options: [:], completionHandler: nil) }
		}, onCancel: onCancel)
	}

    /// Show alert
    ///
    /// - Parameters:
    ///   - title: the title string
    ///   - message: the message string
    ///   - actionTitle: the action title string
    ///   - okAction: the completion handler to execute when user tap on "OK"
    ///   - onCancel: the completion handler to execute when user tap on "Cancel"
    static func showAlert(title: String? = nil, message: String = "", actionTitle: String = "", showDelete: Bool = false, deleteTitle: String = "Delete", okAction: VoidBlock? = nil, deleteAction: VoidBlock? = nil, onCancel: VoidBlock? = nil) {
        genLightHaptic()
        DispatchQueue.main.async {
            guard shouldShowAlert else { return }
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { _ in
                onCancel?()
            }

            alertController.addAction(cancelAction)

            if actionTitle.isEmpty == false {
                let openAction = UIAlertAction(title: actionTitle, style: .default) { _ in
                    okAction?()
                }
                alertController.addAction(openAction)
            }

            if showDelete {
                let delete = UIAlertAction(title: deleteTitle, style: .destructive) { _ in
                    deleteAction?()
                }
                alertController.addAction(delete)
            }

            UINavigationController.topViewController?.present(alertController, animated: true, completion: nil)
        }
    }

    /// Show action sheet
    ///
    /// - Parameters:
    ///   - title: the title string
    ///   - message: the message string
    ///   - actionTitle: the action title string
    ///   - okAction: the completion handler to execute when user tap on "OK"
    static func showAlert(title: String? = nil, message: String, actionTitle: String, okAction: VoidBlock? = nil) {
        showAlert(title: title, message: message, actionTitle: actionTitle, okAction: okAction, onCancel: nil)
    }
}
