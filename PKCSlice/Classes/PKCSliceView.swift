//Copyright (c) 2017 pikachu987 <pikachu77769@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import UIKit

protocol SliceViewDelegate: class {
    func sliceViewGesture(_ gesture: UITapGestureRecognizer)
}

open class PKCSliceView: UIView {
    
    // MARK: var
    
    weak var delegate: SliceViewDelegate?
    
    private var tapGestureRecognizer: UITapGestureRecognizer?
    
    
    // MARK: func
    
    /// remove
    func remove(){
        self.removeGesture()
        self.removeFromSuperview()
    }
    
    /// removeGesture
    private func removeGesture(){
        if let gesture = self.tapGestureRecognizer{
            self.removeGestureRecognizer(gesture)
        }
        self.tapGestureRecognizer = nil
    }
    
    /// addGesture
    private func addGesture(){
        self.isUserInteractionEnabled = true
        self.removeGesture()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.action(_:)))
        self.tapGestureRecognizer = tapGesture
        self.addGestureRecognizer(tapGesture)
    }
    
    /// slice
    func slice(index: Int,
               count: CGFloat,
               inclination: CGFloat,
               isTopFill: Bool,
               isBottomFill: Bool,
               size: CGSize){
        self.clipsToBounds = true
        self.addGesture()
        
        let bezierPath = PKCBezierPath(
            index: index,
            count: count,
            inclination: inclination,
            isTopFill: isTopFill,
            isBottomFill: isBottomFill,
            size: size
        )
        let sliceLayer = CAShapeLayer()
        sliceLayer.path = bezierPath.cgPath
        self.layer.mask = sliceLayer
    }
    
    
    
    /// slice Top
    func sliceTop(count: CGFloat, inclination: CGFloat, size: CGSize){
        self.clipsToBounds = true
        self.addGesture()
        
        let bezierPath = PKCBezierPath(topCount: count, inclination: inclination, size: size)
        let sliceLayer = CAShapeLayer()
        sliceLayer.path = bezierPath.cgPath
        self.layer.mask = sliceLayer
    }
    
    /// slice Bottom
    func sliceBottom(count: CGFloat, inclination: CGFloat, size: CGSize){
        self.clipsToBounds = true
        self.addGesture()
        
        let bezierPath = PKCBezierPath(bottomCount: count, inclination: inclination, size: size)
        let sliceLayer = CAShapeLayer()
        sliceLayer.path = bezierPath.cgPath
        self.layer.mask = sliceLayer
    }
    
    /// action
    @objc private func action(_ sender: UITapGestureRecognizer){
        self.delegate?.sliceViewGesture(sender)
    }
    
    /// isTouch Point
    func isTouch(_ point: CGPoint) -> Bool{
        guard let isTouch = (self.layer.mask as? CAShapeLayer)?.path?.contains(point) else{ return false }
        return isTouch
    }
}
