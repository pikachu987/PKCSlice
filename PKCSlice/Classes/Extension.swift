//
//  Extension.swift
//  Pods
//
//  Created by guanho on 2017. 4. 16..
//
//

import UIKit

extension UIView{
    //오토레이아웃
    func addFullConstraints(_ superView: UIView){
        self.translatesAutoresizingMaskIntoConstraints = false
        let view_constraint_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self])
        let view_constraint_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutFormatOptions.alignAllLeading, metrics: nil, views: ["view": self])
        superView.addConstraints(view_constraint_H)
        superView.addConstraints(view_constraint_V)
    }
}
