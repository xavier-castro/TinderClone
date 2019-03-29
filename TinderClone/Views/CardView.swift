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

		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
		addGestureRecognizer(panGesture)
	}

	@objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
		switch gesture.state {
		case .changed:
			let translation = gesture.translation(in: nil)
			self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
		case .ended:
			UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
				self.transform = .identity
			}) { (_) in

			}
		default:
			()
		}

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError()
	}

}
