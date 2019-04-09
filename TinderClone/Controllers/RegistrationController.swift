//
//  RegistrationController.swift
//  TinderClone
//
//  Created by Xavier Castro on 4/9/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class RegistrationController: UIViewController {

	// UI Components

	let registrationViewModel = RegistrationViewModel()

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
		textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
		return textField
	}()

	let emailTextField: CustomTextField = {
		let textField = CustomTextField(padding: 16)
		textField.placeholder = "Enter email"
		textField.keyboardType = .emailAddress
		textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
		return textField
	}()

	let passwordTextField: CustomTextField = {
		let textField = CustomTextField(padding: 16)
		textField.placeholder = "Enter password"
		textField.isSecureTextEntry = true
		textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
		return textField
	}()

	let registerButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Register", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
		button.backgroundColor = .lightGray
		button.setTitleColor(.gray, for: .disabled)
		button.isEnabled = false
		button.heightAnchor.constraint(equalToConstant: 44).isActive = true
		button.layer.cornerRadius = 22
		button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
		return button
	}()

	@objc fileprivate func handleRegister() {
		self.handleTapDismiss()
		guard let email = emailTextField.text else { return }
		guard let password = passwordTextField.text else { return }
		Auth.auth().createUser(withEmail: email, password: password) { (res, err) in

			if let err = err {
				print(err)
				self.showHUDWithErr(error: err)
				return
			}

			self.showHUDWithSuccess()

		}
	}

	fileprivate func showHUDWithErr(error: Error) {
		let hud = JGProgressHUD(style: .dark)
		hud.textLabel.text = "Failed registration"
		hud.indicatorView = JGProgressHUDErrorIndicatorView()
		hud.detailTextLabel.text = error.localizedDescription
		hud.show(in: self.view)
		hud.dismiss(afterDelay: 3)
	}

	fileprivate func showHUDWithSuccess() {
		let hud = JGProgressHUD(style: .dark)
		hud.indicatorView = JGProgressHUDSuccessIndicatorView()
		hud.textLabel.text = "Successfully registered!"
		hud.show(in: self.view)
		hud.dismiss(afterDelay: 3)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupGradientLayer()
		setupLayout()
		setupNotificationObservers()
		setupTapGesture()
		setupRegistrationViewModelObserver()
	}

	// MARK:- Private

	fileprivate func setupRegistrationViewModelObserver() {
		registrationViewModel.isFormValidObserver = { [unowned self] (isFormValid) in
			self.registerButton.isEnabled = isFormValid
			if isFormValid {
				self.registerButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
				self.registerButton.setTitleColor(.white, for: .normal)
			} else {
				self.registerButton.backgroundColor = .lightGray
				self.registerButton.setTitleColor(.gray, for: .normal)
			}
		}
	}

	fileprivate func setupNotificationObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		NotificationCenter.default.removeObserver(self) // You'll have a retain cycle
	}

	@objc fileprivate func handleKeyboardWillHide() {
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
			self.view.transform = .identity
		})
	}

	fileprivate func setupTapGesture() {
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
	}

	@objc fileprivate func handleTapDismiss() {
		self.view.endEditing(true)
	}

	@objc fileprivate func handleKeyboardShow(notification: Notification) {
		guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
		let keyboardFrame = value.cgRectValue
		print(keyboardFrame)
		// Figure out how tall the gap is from the register button to the bottom of the screen
		let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
		let difference = keyboardFrame.height - bottomSpace
		self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 15)
	}

	@objc fileprivate func handleTextChange(textField: UITextField) {
		if textField == fullNameTextField {
			registrationViewModel.fullName = textField.text
		} else if textField == emailTextField {
			registrationViewModel.email = textField.text
		} else {
			registrationViewModel.password = textField.text
		}
	}

	lazy var verticalStackView: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [
			fullNameTextField,
			emailTextField,
			passwordTextField,
			registerButton
			])
		sv.axis = .vertical
		sv.distribution = .fillEqually
		sv.spacing = 8
		return sv
	}()

	lazy var overallStackView = UIStackView(arrangedSubviews: [
		selectPhotoButton,
		verticalStackView
		])

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		if self.traitCollection.verticalSizeClass == .compact {
			overallStackView.axis = .horizontal
		} else {
			overallStackView.axis = .vertical
		}
	}

	fileprivate func setupLayout() {
		overallStackView.axis = .vertical
		overallStackView.spacing = 8
		selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
		view.addSubview(overallStackView)
		overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
		overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}

	let gradientLayer = CAGradientLayer()

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		gradientLayer.frame = view.bounds
	}

	fileprivate func setupGradientLayer() {
		let topColor = #colorLiteral(red: 0.9893651605, green: 0.38098979, blue: 0.3827672601, alpha: 1)
		let bottomColor = #colorLiteral(red: 0.8867518902, green: 0.1072896793, blue: 0.4637203217, alpha: 1)
		// Make sure to use cgColor
		gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
		gradientLayer.locations = [0, 1]
		view.layer.addSublayer(gradientLayer)
		gradientLayer.frame = view.bounds
	}

}
