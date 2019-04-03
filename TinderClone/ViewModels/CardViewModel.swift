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

struct CardViewModel {
	// We'll define the properties that are view will display/render out
	let imageNames: [String]
	let attributedString: NSAttributedString
	let textAlignment: NSTextAlignment
}
