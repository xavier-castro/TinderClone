//
//  CustomTextField.swift
//  TinderClone
//
//  Created by Xavier Castro on 4/9/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
	
	let padding: CGFloat
	let height: CGFloat
	
	init(padding: CGFloat, height: CGFloat) {
		self.padding = padding
		self.height = height
		super.init(frame: .zero)
		layer.cornerRadius = 25
		backgroundColor = .white
		clearButtonMode = .whileEditing
	}
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: padding, dy: 0)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: padding, dy: 0)
	}
	
	override var intrinsicContentSize: CGSize {
		return .init(width: 0, height: height)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
