//
//  SliceImagesViewController.swift
//  PKCSlice
//
//  Created by guanho on 2017. 4. 16..
//  Copyright © 2017년 CocoaPods. All rights reserved.
//

import UIKit
import PKCSlice

class SliceImagesViewController: UIViewController {
    @IBOutlet weak var superView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "SliceImages"
        
        var images = [UIImage]()
        images.append(UIImage(named: "4.png")!)
        images.append(UIImage(named: "3.png")!)
        images.append(UIImage(named: "2.png")!)
        images.append(UIImage(named: "1.png")!)
        let sliceView = PKCSlice(self.superView, sliceImages: images)
        sliceView.delegate = self
    }
}


extension SliceImagesViewController: PKCSliceDelegate{
    func pkcSliceTouch(_ index: Int) {
        let alertController = UIAlertController(title: "PKCSlice", message: "Index of touched: \(index)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
