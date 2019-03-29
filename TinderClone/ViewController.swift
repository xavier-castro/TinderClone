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


		let buttonsStackView = HomeBottomControlsStackView()
		
		let overallStackView = UIStackView(arrangedSubviews: [topStackView, blueView, buttonsStackView])
		overallStackView.axis = .vertical
		view.addSubview(overallStackView)
		overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
	}


}

