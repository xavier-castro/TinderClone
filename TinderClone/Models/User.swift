//
//  User.swift
//  TinderClone
//
//  Created by Xavier Castro on 4/2/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
	var name: String?
	var age: Int?
	var profession: String?
	var imageUrl1: String?
	var uid: String?

	init(dictionary: [String: Any]) {
		// We'll initialize our user here
		self.name = dictionary["fullName"] as? String ?? ""
		self.age = dictionary["age"] as? Int
		self.profession = dictionary["profession"] as? String
		self.imageUrl1 = dictionary["imageUrl1"] as? String ?? ""
		self.uid = dictionary["uid"] as? String ?? ""
	}

	func toCardViewModel() -> CardViewModel {
		let attributedText = NSMutableAttributedString(string: name ?? "", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
		let ageString = age != nil ? "\(age!)" : ""
		attributedText.append(NSMutableAttributedString(string: "  \(ageString)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
		let professionString = profession != nil ? profession! : ""
		attributedText.append(NSMutableAttributedString(string: "\n\(professionString)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
		return CardViewModel(imageNames: [imageUrl1 ?? ""], attributedString: attributedText, textAlignment: .left)
	}
}
