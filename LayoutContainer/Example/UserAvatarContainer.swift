//
//  UserAvatarContainer.swift
//  LayoutContainer
//
//  Created by jiaxin on 2019/6/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import UIKit

class UserAvatarContainer: LayoutContainer {
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lufei.jpg")
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        return imageView
    }()
    lazy var vipImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "VIP")
        return imageView
    }()

    override func initializeViews() {
        super.initializeViews()

        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.masksToBounds = true
        //需要用owningView当做父视图
        owningView?.addSubview(avatarImageView)
        avatarImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        avatarImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        vipImageView.translatesAutoresizingMaskIntoConstraints = false
        owningView?.addSubview(vipImageView)
        vipImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        vipImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        vipImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        vipImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        //如果是通过约束布局，这里可以根据layoutFrame(不能使用frame、bounds、center)进行布局调整
        avatarImageView.layer.cornerRadius = layoutFrame.size.height/2
    }
}
