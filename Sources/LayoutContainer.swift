//
//  LayoutContainer.swift
//  LayoutContainer
//
//  Created by jiaxin on 2019/6/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import UIKit

/// 仅能被addLayoutGuide一次，不允许被removeLayoutGuide。不然initializeViews会被调用多次，导致重复创建视图！
/// 如果使用约束布局，仅能使用layoutFrame获取布局信息（不可以使用frame、bounds、center）
/// 如果使用frame布局，仅能使用frame、bounds、center获取布局信息（不可以使用layoutFrame）
open class LayoutContainer: UILayoutGuide {
    override weak open var owningView: UIView? {
        didSet {
            if owningView != nil {
                owningView?.layoutSubviewsCallback = {[weak self] in
                    self?.layoutSubviews()
                }
                initializeViews()
            }
        }
    }
    open var frame: CGRect {
        set(newFrame) {
            bounds = CGRect(x: 0, y: 0, width: newFrame.size.width, height: newFrame.size.height)
            center = CGPoint(x: newFrame.origin.x + newFrame.size.width/2, y: newFrame.origin.y + newFrame.size.height/2)
        }
        get {
            return CGRect(x: center.x - bounds.size.width/2, y: center.y - bounds.size.height/2, width: bounds.size.width, height: bounds.size.height)
        }
    }
    open var bounds: CGRect = .zero
    open var center: CGPoint = .zero

    public override init() {
        super.init()

        _ = UIView.swizzleLayoutSubviews
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        _ = UIView.swizzleLayoutSubviews
    }

    /// 子视图需要在initializeViews方法里面进行初始化
    open func initializeViews() {}
    /// 子视图的布局在layoutSubviews进行调整
    open func layoutSubviews() {}
}

fileprivate extension UIView {
    struct AssociatedKeyStruct {
        static var layout = "layout"
    }

    var layoutSubviewsCallback: (()->())? {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKeyStruct.layout, new, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeyStruct.layout) as? ()->()
        }
    }

    @objc func swizzledLayoutSubviews() {
        swizzledLayoutSubviews()

        layoutSubviewsCallback?()
    }

    static let swizzleLayoutSubviews: Void = {
        let aClass: AnyClass! = object_getClass(UIView())
        let originalMethod = class_getInstanceMethod(aClass, #selector(layoutSubviews))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(swizzledLayoutSubviews))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()
}
