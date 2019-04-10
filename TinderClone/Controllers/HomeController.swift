//
//  HomeController.swift
//  TinderClone
//
//  Created by Xavier Castro on 3/29/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class HomeController: UIViewController {

	let topStackView = TopNavigationStackView()
	let cardsDeckView = UIView()
	let bottomControls = HomeBottomControlsStackView()
	var cardViewModels = [CardViewModel]()
	var lastFetchedUser: User?

	override func viewDidLoad() {
		super.viewDidLoad()
		topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
		bottomControls.refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
		setupLayout()
		setupFirestoreUserCards()
		fetchUsersFromFirestore()
	}

	// MARK:- Fileprivate

	fileprivate func fetchUsersFromFirestore() {
		let hud = JGProgressHUD(style: .dark)
		hud.textLabel.text = "Fetching Users..."
		hud.show(in: view)
		let query = Firestore.firestore().collection("users").order(by: "uid").start(after: [lastFetchedUser?.uid ?? ""]).limit(to: 2)
		query.getDocuments { (snapshot, err) in
			hud.dismiss()
			if let err = err {
				print("Failed to fetch users:", err)
				return
			}
			snapshot?.documents.forEach({ (documentSnapshot) in
				let userDictionary = documentSnapshot.data()
				let user = User(dictionary: userDictionary)
				self.cardViewModels.append(user.toCardViewModel())
				self.lastFetchedUser = user
				self.setupCardFromUser(user: user)
			})
		}
	}

	fileprivate func setupCardFromUser(user: User) {
		let cardView = CardView(frame: .zero)
		cardView.cardViewModel = user.toCardViewModel()
		cardsDeckView.addSubview(cardView)
		cardView.fillSuperview()
	}

	@objc fileprivate func handleSettings() {
		print("Show registration page")
		let registrationController = RegistrationController()
		present(registrationController, animated: true, completion: nil)
	}

	@objc fileprivate func handleRefresh() {
		fetchUsersFromFirestore()
	}

	fileprivate func setupFirestoreUserCards() {
		cardViewModels.forEach { (cardVM) in
			let cardView = CardView(frame: .zero)
			cardView.cardViewModel = cardVM
			cardsDeckView.addSubview(cardView)
			cardsDeckView.sendSubviewToBack(cardView)
			cardView.fillSuperview()
		}
	}

	fileprivate func setupLayout() {
		view.backgroundColor = .white
		let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomControls])
		overallStackView.axis = .vertical
		view.addSubview(overallStackView)
		overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
		overallStackView.isLayoutMarginsRelativeArrangement = true
		overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
		overallStackView.bringSubviewToFront(cardsDeckView)
	}


}

