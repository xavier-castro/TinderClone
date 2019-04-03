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

	let cardViewModels: [CardViewModel] = {
		let producers = [
			User(name: "Kelly", age: 23, profession: "DJ", imageNames: ["kelly1", "kelly2", "kelly3"]),
			User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"]),
			Advertiser(title: "Slide Out Menu", brandName: "Lets Build That App", posterPhotoName: "slide_out_menu_poster")
		] as [ProducesCardViewModel]

		let viewModels = producers.map({return $0.toCardViewModel()})
		return viewModels
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupLayout()
		setupDummyCards()
	}

	// MARK:- Fileprivate

	fileprivate func setupDummyCards() {
		cardViewModels.forEach { (cardVM) in
			let cardView = CardView(frame: .zero)
			cardView.cardViewModel = cardVM
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

