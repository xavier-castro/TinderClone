//
//  HomeController.swift
//  TinderClone
//
//  Created by Xavier Castro on 3/29/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {

	let topStackView = TopNavigationStackView()
	let cardsDeckView = UIView()
	let buttonsStackView = HomeBottomControlsStackView()
	var cardViewModels = [CardViewModel]()

	override func viewDidLoad() {
		super.viewDidLoad()
		topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
		setupLayout()
		setupDummyCards()
		fetchUsersFromFirestore()
	}

	// MARK:- Fileprivate

	fileprivate func fetchUsersFromFirestore() {
		Firestore.firestore().collection("users").getDocuments { (snapshot, err) in
			if let err = err {
				print("Failed to fetch users:", err)
				return
			}
			snapshot?.documents.forEach({ (documentSnapshot) in
				let userDictionary = documentSnapshot.data()
				let user = User(dictionary: userDictionary)
				self.cardViewModels.append(user.toCardViewModel())
			})
			self.setupDummyCards()
		}
	}

	@objc fileprivate func handleSettings() {
		print("Show registration page")
		let registrationController = RegistrationController()
		present(registrationController, animated: true, completion: nil)
	}

	fileprivate func setupDummyCards() {
		cardViewModels.forEach { (cardVM) in
			let cardView = CardView(frame: .zero)
			cardView.cardViewModel = cardVM
			cardsDeckView.addSubview(cardView)
			cardView.fillSuperview()
		}
	}

	fileprivate func setupLayout() {
		view.backgroundColor = .white
		let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
		overallStackView.axis = .vertical
		view.addSubview(overallStackView)
		overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
		overallStackView.isLayoutMarginsRelativeArrangement = true
		overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
		overallStackView.bringSubviewToFront(cardsDeckView)
	}


}

