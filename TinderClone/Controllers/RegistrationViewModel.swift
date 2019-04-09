//
//  RegistrationViewModel.swift
//  TinderClone
//
//  Created by Xavier Castro on 4/9/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {

	var bindableIsRegistering = Bindable<Bool>()
	var bindableImage = Bindable<UIImage>()
	var bindableIsFormValid = Bindable<Bool>()

	var fullName: String? { didSet {checkFormValidity()} }
	var email: String? { didSet {checkFormValidity()} }
	var password: String? { didSet {checkFormValidity()} }

	func performRegistration(completion: @escaping (Error?) -> ()) {
		guard let email = email else { return }
		guard let password = password else { return }
		bindableIsRegistering.value = true
		Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
			if let err = err {
				completion(err)
				return
			}
			let filename = UUID().uuidString
			let ref = Storage.storage().reference(withPath: "/images/\(filename)")
			let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
			ref.putData(imageData, metadata: nil, completion: { (_, err) in
				if let err = err {
					completion(err)
					return
				}
				ref.downloadURL(completion: { (url, err) in
					if let err = err {
						completion(err)
						return
					}
					self.bindableIsRegistering.value = false
					print("Download url of our image is:", url?.absoluteString ?? "")
				})
			})
			
		}
	}

	fileprivate func checkFormValidity() {
		let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
		bindableIsFormValid.value = isFormValid
	}
}
