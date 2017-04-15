//
//  SliceColorsViewController.swift
//  PKCSlice
//
//  Created by guanho on 2017. 4. 16..
//  Copyright © 2017년 CocoaPods. All rights reserved.
//

import UIKit
import PKCSlice

class SliceColorsViewController: UIViewController {
    @IBOutlet weak var superView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "SliceColors"
        
        var bgColors = [UIColor]()
        bgColors.append(.red)
        bgColors.append(.green)
        bgColors.append(.blue)
        let sliceView = PKCSlice(self.superView, bgColors: bgColors, inclination: -30)
        sliceView.delegate = self
    }
}


extension SliceColorsViewController: PKCSliceDelegate{
    func pkcSliceTouch(_ index: Int) {
        let alertController = UIAlertController(title: "PKCSlice", message: "Index of touched: \(index)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
