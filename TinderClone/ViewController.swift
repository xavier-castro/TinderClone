//
//  ViewController.swift
//  TinderClone
//
//  Created by Xavier Castro on 3/29/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let subviews = [UIColor.gray, UIColor.darkGray, UIColor.black].map { (color) -> UIView in
			let v = UIView()
			v.backgroundColor = color
			return v
		}

		let topStackView = UIStackView(arrangedSubviews: subviews)
		topStackView.distribution = .fillEqually
		topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true

		let blueView = UIView()
		blueView.backgroundColor = .blue

		let yellowView = UIView()
		yellowView.backgroundColor = .yellow
		yellowView.heightAnchor.constraint(equalToConstant: 120).isActive = true

		let stackView = UIStackView(arrangedSubviews: [topStackView, blueView, yellowView])
//		stackView.distribution = .fillEqually
		stackView.axis = .vertical

		view.addSubview(stackView)
		stackView.fillSuperview()
	}


}

