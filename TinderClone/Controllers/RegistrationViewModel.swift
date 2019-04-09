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
				self.bindableIsRegistering.value = false
				completion(err)
				return
			}
			self.saveImageToFirebase(completion: completion)
		}
	}

	fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> ()) {
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
				let imageUrl = url?.absoluteString ?? ""
				self.saveInfoToFirestore(imageUrl: imageUrl, completion: completion)
			})
		})
	}

	fileprivate func saveInfoToFirestore(imageUrl: String, completion: @escaping (Error?) -> ()) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		let docData = ["fullName": fullName ?? "", "uid": uid, "imageUrl1": imageUrl]
		Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
			if let err = err {
				completion(err)
				return
			}
			completion(nil)
		}
	}

	fileprivate func checkFormValidity() {
		let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
		bindableIsFormValid.value = isFormValid
	}
}
