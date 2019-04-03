//
//  CardView.swift
//  TinderClone
//
//  Created by Xavier Castro on 3/29/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit

class CardView: UIView {

	var cardViewModel: CardViewModel! {
		didSet {
			imageView.image = UIImage(named: cardViewModel.imageName)
			informationLabel.attributedText = cardViewModel.attributedString
			informationLabel.textAlignment = cardViewModel.textAlignment
		}
	}

	fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
	fileprivate let informationLabel = UILabel()

	// Configurations
	fileprivate let threshold: CGFloat = 100

	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.cornerRadius = 10
		clipsToBounds = true
		imageView.contentMode = .scaleAspectFill
		addSubview(imageView)
		imageView.fillSuperview()

		setupGradientLayer()

		addSubview(informationLabel)
		informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))

		informationLabel.text = "TEST NAME TEST NAME AGE"
		informationLabel.textColor = .white
		informationLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
		informationLabel.numberOfLines = 0

		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
		addGestureRecognizer(panGesture)
	}

	let gradientLayer = CAGradientLayer()

	fileprivate func setupGradientLayer() {
		// How we can draw a gradient with Swift
		gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
		gradientLayer.locations = [0.5, 1.1]

		layer.addSublayer(gradientLayer)
	}

	override func layoutSubviews() {
		// In here you know what your CardView frame will be
		gradientLayer.frame = self.frame
	}

	@objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
		switch gesture.state {
		case .changed:
			handleChanged(gesture)
		case .ended:
			handleEnded(gesture)
		default:
			()
		}

	}

	fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
		let translation = gesture.translation(in: nil)
		let degrees: CGFloat = translation.x / 20
		let angle = degrees * .pi / 180
		let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
		self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
	}

	fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
		let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
		let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold

		UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
			if shouldDismissCard {
				self.frame = CGRect(x: 1000 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
			} else {
				self.transform = .identity
			}
		}) { (_) in
			self.transform = .identity
			if shouldDismissCard {
				self.removeFromSuperview()
			}
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError()
	}

}
