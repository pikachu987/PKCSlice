//
//  PKCSliceImageView.swift
//  Pods
//
//  Created by guanho on 2017. 4. 16..
//
//

import UIKit

class PKCSliceImageView: UIImageView {
    init(_ image: UIImage) {
        super.init(image: image)
        self.backgroundColor = .clear
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
