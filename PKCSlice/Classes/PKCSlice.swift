//
//  PKCSlice.swift
//  Pods
//
//  Created by guanho on 2017. 4. 16..
//
//

import UIKit


// MARK: PKCSliceDelegate
public protocol PKCSliceDelegate {
    func pkcSliceTouch(_ index: Int)
}

/**
 Slice Button
 
 To use UIImage, use init.
 init(_ superView: UIView, sliceImages: [UIImage], inclination: CGFloat = 30)
 
 To use UIColor, use init.
 init(_ superView: UIView, bgColors: [UIColor], inclination: CGFloat = 30)
 
 To use UIView, use init.
 init(_ superView: UIView, views: [UIView], inclination: CGFloat = 30)
 */

open class PKCSlice: UIView {
    open var delegate: PKCSliceDelegate?
    
    
    
    
    //MARK: init
    private init(_ superView: UIView){
        super.init(frame: CGRect.zero)
        self.clipsToBounds = true
        superView.addSubview(self)
        self.addFullConstraints(superView)
        self.layoutIfNeeded()
    }
    
    
    //images init
    public convenience init(_ superView: UIView, sliceImages: [UIImage], inclination: CGFloat = 30) {
        self.init(superView)
        for index in 0..<sliceImages.count {
            let sliceView = PKCSliceView(index, count: sliceImages.count, inclination: inclination)
            sliceView.setSliceFrame(
                y: index == 0 ? 0 : self.bounds.height/CGFloat(sliceImages.count)*CGFloat(index),
                width: self.bounds.width,
                height: self.bounds.height/CGFloat(sliceImages.count)
            )
            sliceView.delegate = self
            self.addSubview(sliceView)
            
            let sliceImageView = PKCSliceImageView(sliceImages[index])
            sliceView.addSubview(sliceImageView)
            sliceImageView.addFullConstraints(sliceView)
        }
    }
    
    //bgColors init
    public convenience init(_ superView: UIView, bgColors: [UIColor], inclination: CGFloat = 30) {
        self.init(superView)
        for index in 0..<bgColors.count {
            let sliceView = PKCSliceView(index, count: bgColors.count, inclination: inclination)
            sliceView.setSliceFrame(
                y: index == 0 ? 0 : self.bounds.height/CGFloat(bgColors.count)*CGFloat(index),
                width: self.bounds.width,
                height: self.bounds.height/CGFloat(bgColors.count)
            )
            sliceView.delegate = self
            self.addSubview(sliceView)
            
            sliceView.backgroundColor = bgColors[index]
        }
    }
    
    //views init
    public convenience init(_ superView: UIView, views: [UIView], inclination: CGFloat = 30) {
        self.init(superView)
        for (index, element) in views.enumerated() {
            let sliceView = PKCSliceView(index, count: views.count, inclination: inclination)
            sliceView.setSliceFrame(
                y: index == 0 ? 0 : self.bounds.height/CGFloat(views.count)*CGFloat(index),
                width: self.bounds.width,
                height: self.bounds.height/CGFloat(views.count)
            )
            sliceView.delegate = self
            self.addSubview(sliceView)
            
            sliceView.addSubview(element)
            element.addFullConstraints(sliceView)
        }
    }
    
    
    
    
    
    
    //storyboard
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.autoSlice(true)
    }
    
    
    
    
    
    
    //use storyboard, diagonal up,down type
    //MARK: method
    public func autoSlice(_ isDown: Bool){
        var inclinationList = [CGFloat]()
        self.constraints.forEach { (const) in
            if const.firstAttribute == .top && const.secondAttribute == .bottom{
                inclinationList.append( isDown == true ? -const.constant/2 : const.constant/2)
            }
        }
        self.clipsToBounds = true
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            for (index, element) in self.subviews.enumerated() {
                guard let sliceView = element as? PKCSliceView else {
                    return
                }
                sliceView.initData(
                    index,
                    count: self.subviews.count,
                    inclinationTop: index == 0 ? 0 : inclinationList[index-1],
                    inclinationBottom: index == self.subviews.count-1 ? 0 : inclinationList[index]
                )
                sliceView.setBezierPathDiff(width: sliceView.bounds.width, height: sliceView.bounds.height)
                sliceView.delegate = self
            }
        }
    }
    
    
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



//MARK: extension
extension PKCSlice: PKCSliceViewDelegate{
    func pkcSliceViewGesture(_ index: Int, isCurrentView: Bool) {
        self.delegate?.pkcSliceTouch(isCurrentView ? index : index-1)
    }
}
