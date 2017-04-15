//
//  SliceViewsViewController.swift
//  PKCSlice
//
//  Created by guanho on 2017. 4. 16..
//  Copyright © 2017년 CocoaPods. All rights reserved.
//

import UIKit
import PKCSlice

class SliceViewsViewController: UIViewController {
    @IBOutlet weak var superView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "SliceViews"
        
        var views = [UIView]()
        
        let view1 = UIView()
        view1.backgroundColor = .black
        view1.alpha = 0.9
        views.append(view1)
        
        let view2 = UIView()
        view2.backgroundColor = .black
        view2.alpha = 0.5
        views.append(view2)
        
        let view3 = UIView()
        view3.backgroundColor = .black
        view3.alpha = 0.3
        views.append(view3)
        
        let sliceView = PKCSlice(self.superView, views: views, inclination: 70)
        sliceView.delegate = self
    }
}


extension SliceViewsViewController: PKCSliceDelegate{
    func pkcSliceTouch(_ index: Int) {
        let alertController = UIAlertController(title: "PKCSlice", message: "Index of touched: \(index)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
