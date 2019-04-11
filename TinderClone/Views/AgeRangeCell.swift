//
//  AgeRangeCell.swift
//  TinderClone
//
//  Created by Xavier Castro on 4/11/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit

class AgeRangeCell: UITableViewCell {

	let minSlider: UISlider = {
		let slider = UISlider()
		slider.minimumValue = 18
		slider.maximumValue = 100
		return slider
	}()

	let maxSlider: UISlider = {
		let slider = UISlider()
		slider.minimumValue = 18
		slider.maximumValue = 100
		return slider
	}()

	let minLabel: UILabel = {
		let label = AgeRangeLabel()
		label.text = "Min:"
		return label
	}()

	let maxLabel: UILabel = {
		let label = AgeRangeLabel()
		label.text = "Max:"
		return label
	}()

	class AgeRangeLabel: UILabel {
		override var intrinsicContentSize: CGSize {
			return .init(width: 80, height: 0)
		}
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		let overallStackView = UIStackView(arrangedSubviews: [
			UIStackView(arrangedSubviews: [minLabel, minSlider]),
			UIStackView(arrangedSubviews: [maxLabel, maxSlider])
			])
		overallStackView.axis = .vertical
		overallStackView.spacing = 16
		overallStackView.distribution = .fillEqually
		addSubview(overallStackView)
		overallStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
