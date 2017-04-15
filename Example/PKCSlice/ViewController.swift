//
//  ViewController.swift
//  PKCSlice
//
//  Created by pikachu987 on 04/15/2017.
//  Copyright (c) 2017 pikachu987. All rights reserved.
//

import UIKit
import PKCSlice

class ViewController: UIViewController {
    @IBOutlet weak var sliceView: PKCSlice!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.sliceView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: PKCSliceDelegate{
    func pkcSliceTouch(_ index: Int) {
        if index == 0{
            self.performSegue(withIdentifier: "StoryboardTypeController", sender: nil)
        }else if index == 1{
            self.performSegue(withIdentifier: "SliceImagesViewController", sender: nil)
        }else if index == 2{
            self.performSegue(withIdentifier: "SliceColorsViewController", sender: nil)
        }else if index == 3{
            self.performSegue(withIdentifier: "SliceViewsViewController", sender: nil)
        }
    }
}
