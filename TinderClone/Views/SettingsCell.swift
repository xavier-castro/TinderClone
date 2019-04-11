//
//  SettingsCell.swift
//  TinderClone
//
//  Created by Xavier Castro on 4/10/19.
//  Copyright © 2019 Xavier Castro. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

	class SettingsTextField: UITextField {

		override func textRect(forBounds bounds: CGRect) -> CGRect {
			return bounds.insetBy(dx: 16, dy: 0)
		}

		override func editingRect(forBounds bounds: CGRect) -> CGRect {
			return bounds.insetBy(dx: 16, dy: 0)
		}

		override var intrinsicContentSize: CGSize {
			return .init(width: 0, height: 44)
		}
	}

	let textField: UITextField = {
		let tf = SettingsTextField()
		tf.placeholder = "Enter Name"
		tf.textColor = .black
		tf.backgroundColor = .white
		return tf
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(textField)
		textField.fillSuperview()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
