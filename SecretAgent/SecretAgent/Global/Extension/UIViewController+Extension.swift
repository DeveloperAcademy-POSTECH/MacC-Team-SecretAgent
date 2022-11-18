//
//  UIViewController+Extension.swift
//  Samplero
//
//  Created by Minkyeong Ko on 2022/10/09.
//

import UIKit

extension UIViewController {
	var screenWidth: Double {
		return UIScreen.main.bounds.size.width
	}

	var screenHeight: Double {
		return UIScreen.main.bounds.size.height
	}

	func hideKeyboardWhenTappedAround() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}

	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}
