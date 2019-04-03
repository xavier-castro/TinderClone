//
//  HomeController.swift
//  TinderClone
//
//  Created by Xavier Castro on 3/29/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

	let topStackView = TopNavigationStackView()
	let cardsDeckView = UIView()
	let buttonsStackView = HomeBottomControlsStackView()

	let cardViewModels = [
		User(name: "Kelly", age: 23, profession: "DJ", imageName: "lady5c").toCardViewModel(),
		User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c").toCardViewModel()
	]

	override func viewDidLoad() {
		super.viewDidLoad()
		setupLayout()
		setupDummyCards()
	}

	// MARK:- Fileprivate

	fileprivate func setupDummyCards() {
		cardViewModels.forEach { (cardVM) in
			let cardView = CardView(frame: .zero)
			cardView.imageView.image = UIImage(named: cardVM.imageName)
			cardView.informationLabel.attributedText = cardVM.attributedString
			cardView.informationLabel.textAlignment = cardVM.textAlignment
			cardsDeckView.addSubview(cardView)
			cardView.fillSuperview()
		}
	}

	fileprivate func setupLayout() {
		let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
		overallStackView.axis = .vertical
		view.addSubview(overallStackView)
		overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
		overallStackView.isLayoutMarginsRelativeArrangement = true
		overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)

		overallStackView.bringSubviewToFront(cardsDeckView)
	}


}

