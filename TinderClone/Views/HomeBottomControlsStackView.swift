//
//  HomeBottomControlsStackView.swift
//  TinderClone
//
//  Created by Xavier Castro on 3/29/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		distribution = .fillEqually
		heightAnchor.constraint(equalToConstant: 100).isActive = true

		let subviews = [#imageLiteral(resourceName: "rewind"), #imageLiteral(resourceName: "decline"), #imageLiteral(resourceName: "star"), #imageLiteral(resourceName: "heart"), #imageLiteral(resourceName: "lightning")].map { (img) -> UIView in
			let button = UIButton(type: .system)
			button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
			return button
		}

		subviews.forEach { (v) in
			addArrangedSubview(v)
		}
	}

	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
