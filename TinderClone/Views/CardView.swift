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
			let imageName = cardViewModel.imageNames.first ?? ""
			imageView.image = UIImage(named: imageName)
			informationLabel.attributedText = cardViewModel.attributedString
			informationLabel.textAlignment = cardViewModel.textAlignment

			// Some dummy bars for now
			(0..<cardViewModel.imageNames.count).forEach { (_) in
				let barView = UIView()
				barView.backgroundColor = barDeselectedColor
				barsStackView.addArrangedSubview(barView)
			}
			barsStackView.arrangedSubviews.first?.backgroundColor = .white
		}
	}

	fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
	fileprivate let informationLabel = UILabel()
	fileprivate let gradientLayer = CAGradientLayer()

	// Configurations
	fileprivate let threshold: CGFloat = 80

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupLayout()

		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
		addGestureRecognizer(panGesture)
		addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
	}

	var imageIndex = 0
	fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)

	@objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
		let tapLocation = gesture.location(in: nil)
		let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
		if shouldAdvanceNextPhoto {
			imageIndex = min(imageIndex + 1, cardViewModel.imageNames.count - 1)
		} else {
			imageIndex = max(0, imageIndex - 1)
		}

		let imageName = cardViewModel.imageNames[imageIndex]
		imageView.image = UIImage(named: imageName)
		barsStackView.arrangedSubviews.forEach { (v) in
			v.backgroundColor = barDeselectedColor
		}
		barsStackView.arrangedSubviews[imageIndex].backgroundColor = .white

	}

	fileprivate func setupLayout() {
		// Custom drawing code
		layer.cornerRadius = 10
		clipsToBounds = true

		setupBarsStackView()

		imageView.contentMode = .scaleAspectFill
		addSubview(imageView)
		imageView.fillSuperview()

		setupBarsStackView()

		// Add a gradient layout
		setupGradientLayer()

		addSubview(informationLabel)
		informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
			padding: .init(top: 0, left: 16, bottom: 16, right: 16))

		informationLabel.textColor = .white
		informationLabel.numberOfLines = 0
	}

	fileprivate let barsStackView = UIStackView()

	fileprivate func setupBarsStackView() {
		addSubview(barsStackView)
		barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,
			padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))

		barsStackView.spacing = 4
		barsStackView.distribution = .fillEqually
	}

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
		case .began:
			superview?.subviews.forEach({ (subview) in
				subview.layer.removeAllAnimations()
			})
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
