//
//  NormalCell.swift
//  LayoutContainer
//
//  Created by jiaxin on 2019/11/26.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import UIKit

class NormalCell: UITableViewCell {
    lazy var avatar = NormalUserAvatar()
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "我是路飞，一个要成为海贼王的男人！"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(avatar)
        contentView.addSubview(descLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        avatar.frame = CGRect(x: 12, y: (contentView.bounds.size.height - 100)/2, width: 100, height: 100)
        descLabel.sizeToFit()
        descLabel.frame = CGRect(x: avatar.frame.maxX + 10, y: (contentView.bounds.size.height - descLabel.bounds.size.height)/2, width: descLabel.bounds.size.width, height: descLabel.bounds.size.height)
    }
}
