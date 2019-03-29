//
//  CardView.swift
//  TinderClone
//
//  Created by Xavier Castro on 3/29/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit

class CardView: UIView {

	fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))

	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.cornerRadius = 10
		clipsToBounds = true

		addSubview(imageView)
		imageView.fillSuperview()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError()
	}

}
