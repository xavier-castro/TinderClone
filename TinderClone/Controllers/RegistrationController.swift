//
//  RegistrationController.swift
//  TinderClone
//
//  Created by Xavier Castro on 4/9/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

	// UI Components
	let selectPhotoButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Select Photo", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
		button.backgroundColor = .white
		button.setTitleColor(.black, for: .normal)
		button.heightAnchor.constraint(equalToConstant: 275).isActive = true
		button.layer.cornerRadius = 16
		return button
	}()

	let fullNameTextField: CustomTextField = {
		let textField = CustomTextField(padding: 16)
		textField.placeholder = "Enter full name"
		textField.backgroundColor = .white
		return textField
	}()

	let emailTextField: CustomTextField = {
		let textField = CustomTextField(padding: 16)
		textField.placeholder = "Enter email"
		textField.keyboardType = .emailAddress
		textField.backgroundColor = .white
		return textField
	}()

	let passwordTextField: CustomTextField = {
		let textField = CustomTextField(padding: 16)
		textField.placeholder = "Enter password"
		textField.isSecureTextEntry = true
		textField.backgroundColor = .white
		return textField
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupGradientLayer()
		view.backgroundColor = .red

		let stackView = UIStackView(arrangedSubviews: [
			selectPhotoButton,
			fullNameTextField,
			emailTextField,
			passwordTextField
			])
		stackView.axis = .vertical
		stackView.spacing = 8
		view.addSubview(stackView)
		stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
		stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}

	fileprivate func setupGradientLayer() {
		let gradientLayer = CAGradientLayer()
		let topColor = #colorLiteral(red: 0.9893651605, green: 0.38098979, blue: 0.3827672601, alpha: 1)
		let bottomColor = #colorLiteral(red: 0.8867518902, green: 0.1072896793, blue: 0.4637203217, alpha: 1)
		// Make sure to use cgColor
		gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
		gradientLayer.locations = [0, 1]
		view.layer.addSublayer(gradientLayer)
		gradientLayer.frame = view.bounds
	}

}
