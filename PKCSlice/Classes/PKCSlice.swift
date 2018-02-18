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

public protocol SliceDelegate: class {
    /// sliceView Touch
    func sliceTouchAction(_ slice: PKCSlice, sliceView: PKCSliceView?, index: Int)
    /// sliceTopView Touch
    func sliceTopTouchAction(_ slice: PKCSlice, sliceView: PKCSliceView)
    /// sliceBottomView Touch
    func sliceBottomTouchAction(_ slice: PKCSlice, sliceView: PKCSliceView)
}

public extension SliceDelegate {
    func sliceTouchAction(_ slice: PKCSlice, sliceView: PKCSliceView?, index: Int){ }
    func sliceTopTouchAction(_ slice: PKCSlice, sliceView: PKCSliceView){ }
    func sliceBottomTouchAction(_ slice: PKCSlice, sliceView: PKCSliceView){ }
}


@IBDesignable
public class PKCSlice: UIView {
    public weak var delegate: SliceDelegate?
    
    
    // MARK: var
    
    
    private var _sliceViewArray = [PKCSliceView]()
    public var sliceViewArray: [PKCSliceView]{
        get{
            return self._sliceViewArray
        }
    }
    
    public var topSliceView: PKCSliceView?{
        didSet{
            self.redraw()
        }
    }
    public var bottomSliceView: PKCSliceView?{
        didSet{
            self.redraw()
        }
    }
    
    
    
    // MARK: Initializers
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
    }
    
    
    public override var intrinsicContentSize: CGSize{
        return CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
    
    
    
    // MARK: Properties
    
    
    @IBInspectable
    public var inclination: CGFloat = 100{
        didSet{
            self.redraw()
        }
    }
    
    
    
    @IBInspectable
    public var hexColors: String = ""{
        didSet{
            self._sliceViewArray = self.hexColors
                .components(separatedBy: ",")
                .map({ (color) -> PKCSliceView in
                    let view = PKCSliceView()
                    view.backgroundColor = UIColor(hexString: color)
                    return view
                })
            self.redraw()
        }
    }
    
    
    @IBInspectable
    public var isTopFill: Bool = false{
        didSet{
            self.redraw()
        }
    }
    
    @IBInspectable
    public var isBottomFill: Bool = false{
        didSet{
            self.redraw()
        }
    }
    
    
    @IBInspectable
    public var topHexColor: String = ""{
        didSet{
            let sliceView = PKCSliceView()
            sliceView.backgroundColor = UIColor(hexString: self.topHexColor)
            self.topSliceView = sliceView
        }
    }
    
    @IBInspectable
    public var bottomHexColor: String = ""{
        didSet{
            let sliceView = PKCSliceView()
            sliceView.backgroundColor = UIColor(hexString: self.bottomHexColor)
            self.bottomSliceView = sliceView
        }
    }
    
    
    
    
    
    
    // MARK: func
    
    /// append PKCSliceView
    @discardableResult
    public func append(_ view: PKCSliceView) -> PKCSliceView{
        self._sliceViewArray.append(view)
        self.redraw()
        return view
    }
    
    /// append PKCSliceViews
    public func append(contentsOf: [PKCSliceView]){
        self._sliceViewArray.append(contentsOf: contentsOf)
        self.redraw()
    }
    
    /// RemoveAll
    public func removeAll(){
        self._sliceViewArray.removeAll()
        self.redraw()
    }
    
    
    
    
    /// remove
    private func remove(){
        self.removeConstraints(self.constraints)
        self.subviews.map({ $0 as? PKCSliceView }).forEach { (element) in
            element?.remove()
        }
    }
    
    /// redraw
    
    public func redraw(){
        self.remove()
        
        
        let sliceArrayView = self._sliceViewArray
        let arrayCount = CGFloat(sliceArrayView.count)
        
        let sliceHeight = self.frame.height/arrayCount + self.inclination
        let size = CGSize(width: self.frame.size.width, height: sliceHeight)
        
        
        // topSlice
        if let sliceView = self.topSliceView, let _ = self._sliceViewArray.first{
            sliceView.delegate = self
            self.addSubview(sliceView)
            sliceView.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraint(sliceView.trailingConstraint(self))
            self.addConstraint(sliceView.leadingConstraint(self))
            
            sliceView.sliceTop(count: arrayCount, inclination: self.inclination, size: size)
        }
        
        // bottomSlice
        if let sliceView = self.bottomSliceView, let _ = self._sliceViewArray.last{
            sliceView.delegate = self
            self.addSubview(sliceView)
            sliceView.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraint(sliceView.trailingConstraint(self))
            self.addConstraint(sliceView.leadingConstraint(self))
            
            sliceView.sliceBottom(count: arrayCount, inclination: self.inclination, size: size)
        }
        
        for (index, element) in sliceArrayView.enumerated() {
            element.delegate = self
            
            self.addSubview(element)
            
            // autolayout
            element.translatesAutoresizingMaskIntoConstraints = false
            
            // leading & trailing
            self.addConstraint(element.trailingConstraint(self))
            self.addConstraint(element.leadingConstraint(self))
            
            // bottom
            if index == Int(arrayCount - 1){ self.addConstraint(element.bottomConstraint(self)) }
            
            // top & height
            if index == 0{
                self.addConstraint(element.topConstraint(self, attribute: .top))
            }else{
                let topConstraint = element.topConstraint(sliceArrayView[index-1], attribute: .bottom, constant: self.inclination.abs)
                topConstraint.priority = UILayoutPriority(900)
                self.addConstraint(topConstraint)
                self.addConstraint(element.heightEqualConstraint(sliceArrayView[index-1]))
            }
            
            
            // slice
            element.slice(
                index: index,
                count: arrayCount,
                inclination: self.inclination,
                isTopFill: self.isTopFill,
                isBottomFill: self.isBottomFill,
                size: size
            )
        }
        
        // topSlice
        if let sliceView = self.topSliceView, let firstView = self._sliceViewArray.first{
            self.addConstraint(sliceView.topConstraint(firstView, attribute: .top))
            self.addConstraint(sliceView.heightEqualConstraint(firstView))
        }
        
        // bottomSlice
        if let sliceView = self.bottomSliceView, let lastView = self._sliceViewArray.last{
            self.addConstraint(sliceView.bottomConstraint(lastView))
            self.addConstraint(sliceView.heightEqualConstraint(lastView))
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.resize()
        })
    }
    
    
    
    
    // resize
    private func resize(){
        let sliceArrayView = self._sliceViewArray
        let arrayCount = CGFloat(sliceArrayView.count)
        
        let sliceHeight = self.frame.height/CGFloat(arrayCount) + self.inclination
        let size = CGSize(width: self.frame.size.width, height: sliceHeight)
        
        for (index, element) in sliceArrayView.enumerated() {
            element.slice(
                index: index,
                count: arrayCount,
                inclination: self.inclination,
                isTopFill: self.isTopFill,
                isBottomFill: self.isBottomFill,
                size: size
            )
        }
        
        if let sliceView = self.topSliceView, let _ = self._sliceViewArray.first{
            sliceView.sliceTop(count: arrayCount, inclination: self.inclination, size: size)
        }
        if let sliceView = self.bottomSliceView, let _ = self._sliceViewArray.last{
            sliceView.sliceBottom(count: arrayCount, inclination: self.inclination, size: size)
        }
    }
    
    
}




extension PKCSlice: SliceViewDelegate{
    //MARK: PKCSliceViewDelegate
    
    func sliceViewGesture(_ gesture: UITapGestureRecognizer) {
        if let topSliceView = self.topSliceView,
            let isTouch = self.topSliceView?.isTouch(gesture.location(in: topSliceView)),
            isTouch && !self.isTopFill{
            self.delegate?.sliceTopTouchAction(self, sliceView: topSliceView)
            return
        }
        
        else if let bottomSliceView = self.bottomSliceView,
            let isTouch = self.bottomSliceView?.isTouch(gesture.location(in: bottomSliceView)),
        isTouch && !self.isBottomFill{
            self.delegate?.sliceBottomTouchAction(self, sliceView: bottomSliceView)
            return
        }
        
        
        guard let view = self.sliceViewArray.filter({ $0.isTouch(gesture.location(in: $0)) }).first else{
            return
        }
        if let index = self.sliceViewArray.index(where: { $0 == view }){
            self.delegate?.sliceTouchAction(self, sliceView: self.sliceViewArray[index], index: index)
        }
    }
}
