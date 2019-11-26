//
//  NormalUserAvatar.swift
//  LayoutContainer
//
//  Created by jiaxin on 2019/11/26.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import UIKit

class NormalUserAvatar: UIView {
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lufei.jpg")
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var vipImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "VIP")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(avatarImageView)
        addSubview(vipImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        avatarImageView.layer.cornerRadius = bounds.size.height/2
        avatarImageView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        let vipWidth: CGFloat = 30
        vipImageView.frame = CGRect(x: avatarImageView.frame.maxX - vipWidth, y: avatarImageView.frame.minY, width: vipWidth, height: vipWidth)
    }
    

}
