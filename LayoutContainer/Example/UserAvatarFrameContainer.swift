//
//  UserAvatarFrameContainer.swift
//  LayoutContainer
//
//  Created by jiaxin on 2019/6/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import UIKit

class UserAvatarFrameContainer: LayoutContainer {
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

    override func initializeViews() {
        super.initializeViews()

        owningView?.addSubview(avatarImageView)
        owningView?.addSubview(vipImageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        //如果是通过frame布局，这里可以根据frame(不能使用layoutFrame)进行布局调整
        //因为avatarImageView和vipImageView还是被添加到cell.contentView上面的，所以这里的frame依然是参考的cell.contentView的布局坐标，请务必熟记于心！！！
        avatarImageView.layer.cornerRadius = bounds.size.height/2
        avatarImageView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: bounds.size.width, height: bounds.size.height)
        let vipWidth: CGFloat = 30
        vipImageView.frame = CGRect(x: avatarImageView.frame.maxX - vipWidth, y: avatarImageView.frame.minY, width: vipWidth, height: vipWidth)
    }
}
