//
//  HomeBottomControlsStackView.swift
//  TinderClone
//
//  Created by Xavier Castro on 3/29/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {

	static func createButton(image: UIImage) -> UIButton {
		let button = UIButton(type: .system)
		button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
		button.imageView?.contentMode = .scaleAspectFill
		return button
	}

	let refreshButton = createButton(image: #imageLiteral(resourceName: "rewind"))
	let dislikeButton = createButton(image: #imageLiteral(resourceName: "decline"))
	let superLikeButton = createButton(image: #imageLiteral(resourceName: "star"))
	let likeButton = createButton(image: #imageLiteral(resourceName: "heart"))
	let specialButton = createButton(image: #imageLiteral(resourceName: "lightning"))

	override init(frame: CGRect) {
		super.init(frame: frame)
		distribution = .fillEqually
		heightAnchor.constraint(equalToConstant: 100).isActive = true
		[refreshButton, dislikeButton, superLikeButton, likeButton, specialButton].forEach { (button) in
			self.addArrangedSubview(button)
		}
	}

	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
