# 优雅的减少视图层级

在实际业务中，我们经常遇到一个业务控件，由几个小控件组合完成。比如用户头像组件：有头像图片、等级图片、红点提示视图等。为了提高封装性和重用性，一般都会自定义一个视图控件来添加这些小控件。这样有一个副作用就是增加了一层视图层级，如下图所示：

![](https://github.com/pujiaxin33/JXExampleImages/blob/master/LayoutContainer/normal.png)

视图层级多了一层，在布局计算时会更加耗时。视图对象多了一个，内存消耗会更多。那有没有办法即保证了控件的封装性，又可以减少一层视图的包裹呢？答案就是它：`UILayoutGuide`，用了它之后的效果如下图：

![](https://github.com/pujiaxin33/JXExampleImages/blob/master/LayoutContainer/guide.png)

减少了一层视图，但是显示效果和封装效果一样。

重要的事情讲三遍：
本方案仅提供一个有趣的思路，并不保证其性能！
本方案仅提供一个有趣的思路，并不保证其性能！
本方案仅提供一个有趣的思路，并不保证其性能！

# `LayoutContainer`

`UILayoutGuide`是iOS9引入的，就是为了解决需要有占位视图的场景。它不会出现在视图层级里面，也不会有视图对象，只会在布局引擎起作用。下面是官方注释可以细细品味：
> UILayoutGuides will not show up in the view hierarchy, but may be used as items in
 an NSLayoutConstraint and represent a rectangle in the layout engine.

所以，创建继承`UILayoutGuide`的`LayoutContainer`类，当做子控件的布局容器。子控件只需要相对`LayoutContainer`布局，就可以实现布局独立，达到其封装性。

# `LayoutContainer`使用示例

## `LayoutContainer`子类化示例

`UserAvatarContainer`就是用户头像的封装控件。内部的子控件，只需要相对self布局即可。

```Swift
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
```

## 添加`LayoutContainer`

```Swift
class ListCell: UITableViewCell {
    lazy var avatarContainer: UserAvatarContainer = {
        UserAvatarContainer()
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addLayoutGuide(avatarContainer)
        avatarContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        avatarContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        avatarContainer.widthAnchor.constraint(equalToConstant: 100).isActive = true
        avatarContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
```

# 注意事项

- `LayoutContainer`的子视图需要在`initializeViews`方法里面进行初始化
- `LayoutContainer`的子视图的布局在`layoutSubviews`进行调整
- `LayoutContainer`仅能被addLayoutGuide一次，不允许被removeLayoutGuide。不然initializeViews会被调用多次，导致重复创建视图！

