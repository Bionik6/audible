//
//  PageCell.swift
//  BrianAudible
//
//  Created by Ibrahima Ciss on 06/09/2016.
//  Copyright © 2016 Ibrahima Ciss. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {

    var page: Page? {
        didSet {
            guard let page = page else { return }

            imageView.image = UIImage(named: page.imageName)
            let font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
            let fontColor = UIColor(white: 0.2, alpha: 1)

            let paragraphStype = NSMutableParagraphStyle()
            paragraphStype.alignment = .center

            let attributedString = NSMutableAttributedString(string: page.title)
            let length = attributedString.string.characters.count
            attributedString.addAttributes([NSParagraphStyleAttributeName: paragraphStype, NSFontAttributeName: font, NSForegroundColorAttributeName: fontColor], range: NSRange(location: 0, length: length))
            attributedString.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSParagraphStyleAttributeName: paragraphStype, NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: fontColor]))
            textView.attributedText = attributedString
        }
    }

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "page1")
        iv.clipsToBounds = true
        return iv
    }()

    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()

    private let textView: UITextView = {
        let tv = UITextView()
        tv.contentInset = UIEdgeInsetsMake(24, 0, 0, 0)
        tv.isEditable = false
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubviews()
        imageView.addAnchor(top: topAnchor, left: leftAnchor, bottom: separatorLine.topAnchor, right: rightAnchor)
        textView.addAnchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        separatorLine.addAnchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func addSubviews() {
        self.addSubview(imageView)
        self.addSubview(textView)
        self.addSubview(separatorLine)
    }

}
