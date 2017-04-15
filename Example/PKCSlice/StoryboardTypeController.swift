//
//  StoryboardTypeController.swift
//  PKCSlice
//
//  Created by guanho on 2017. 4. 16..
//  Copyright © 2017년 CocoaPods. All rights reserved.
//

import UIKit
import PKCSlice

class StoryboardTypeController: UIViewController {
    @IBOutlet weak var sliceView: PKCSlice!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Storyboard Custom"
        
        self.sliceView.autoSlice(false)
        self.sliceView.delegate = self
    }
}


extension StoryboardTypeController: PKCSliceDelegate{
    func pkcSliceTouch(_ index: Int) {
        let alertController = UIAlertController(title: "PKCSlice", message: "Index of touched: \(index)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
