//
// Created by Xavier Castro on 2019-04-11.
// Copyright (c) 2019 Xavier Castro. All rights reserved.
//

import Foundation
import Firebase

class LoginViewModel {

	var isLoggingIn = Bindable<Bool>()
	var isFormValid = Bindable<Bool>()

	var email: String? { didSet { checkFormValidity() } }
	var password: String? { didSet { checkFormValidity() } }

	fileprivate func checkFormValidity() {
		let isValid = email?.isEmpty == false && password?.isEmpty == false
		isFormValid.value = isValid
	}

	func performLogin(completion: @escaping (Error?) -> ()) {
		guard let email = email, let password = password else { return }
		isLoggingIn.value = true
		Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
			completion(err)
		}
	}
}
