//
//  CardViewModel.swift
//  TinderClone
//
//  Created by Xavier Castro on 4/2/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
	func toCardViewModel() -> CardViewModel
}

class CardViewModel {
	// We'll define the properties that are view will display/render out
	let imageNames: [String]
	let attributedString: NSAttributedString
	let textAlignment: NSTextAlignment

	init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
		self.imageNames = imageNames
		self.attributedString = attributedString
		self.textAlignment = textAlignment
	}

	fileprivate var imageIndex = 0 {
		didSet {
			let imageUrl = imageNames[imageIndex]
			imageIndexObserver?(imageIndex, imageUrl)
		}
	}

	// Reactive Programming
	var imageIndexObserver: ((Int, String?) -> ())?

	func advanceToNextPhoto() {
		imageIndex = min(imageIndex + 1, imageNames.count - 1)
	}

	func goToPreviousPhoto() {
		imageIndex = max(0, imageIndex - 1)
	}
}
