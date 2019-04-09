//
//  Bindable.swift
//  TinderClone
//
//  Created by Xavier Castro on 4/9/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import Foundation

class Bindable<T> {
	var value: T? {
		didSet {
			observer?(value)
		}
	}

	var observer: ((T?) -> ())?

	func bind(observer: @escaping (T?) -> ()) {
		self.observer = observer
	}
}
