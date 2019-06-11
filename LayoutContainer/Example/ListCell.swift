//
//  ListCell.swift
//  LayoutContainer
//
//  Created by jiaxin on 2019/6/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    lazy var avatarContainer: UserAvatarContainer = {
        UserAvatarContainer()
    }()
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "我是路飞，一个要成为海贼王的男人！"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addLayoutGuide(avatarContainer)
        avatarContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        avatarContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        avatarContainer.widthAnchor.constraint(equalToConstant: 100).isActive = true
        avatarContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

        //其他控件可以直接参考avatarContainer布局
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descLabel)
        descLabel.leadingAnchor.constraint(equalTo: avatarContainer.trailingAnchor, constant: 10).isActive = true
        descLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        
    }

}
