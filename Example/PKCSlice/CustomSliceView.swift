//
//  CustomSliceView.swift
//  PKCSlice_Example
//
//  Created by Kim Guanho on 2018. 2. 18..
//  Copyright © 2018년 CocoaPods. All rights reserved.
//

import UIKit
import PKCSlice

class CustomSliceView: PKCSliceView {
    @IBOutlet private weak var imageView1: UIImageView!
    @IBOutlet private weak var imageView2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView1.contentMode = .scaleAspectFill
        self.imageView2.contentMode = .scaleAspectFill
        self.imageView1.clipsToBounds = true
        self.imageView2.clipsToBounds = true
        self.imageView1.image = UIImage(named: "1.png")
        self.imageView2.image = UIImage(named: "2.png")
    }
}
