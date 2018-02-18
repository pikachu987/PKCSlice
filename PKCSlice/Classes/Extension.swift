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


public extension PKCSliceView{
    /// addSubviewEdgeConstraint
    @discardableResult
    public func addSubviewEdgeConstraint(
        _ view: UIView,
        leading: CGFloat = 0,
        top: CGFloat = 0,
        trailing: CGFloat = 0,
        bottom: CGFloat = 0) -> [NSLayoutConstraint]{
        
        self.addSubview(view)
        return self.addEdgesConstraints(view, leading: leading, top: top, trailing: trailing, bottom: bottom)
    }
    
    /// addEdgesConstraints
    @discardableResult
    public func addEdgesConstraints(
        _ view: UIView,
        leading: CGFloat = 0,
        top: CGFloat = 0,
        trailing: CGFloat = 0,
        bottom: CGFloat = 0) -> [NSLayoutConstraint]{
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(
            item: self,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view,
            attribute: .leading,
            multiplier: 1,
            constant: leading
        )
        let trailingConstraint = NSLayoutConstraint(
            item: self,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view,
            attribute: .trailing,
            multiplier: 1,
            constant: trailing
        )
        let topConstraint = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: top
        )
        let bottomConstraint = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: bottom
        )
        let constraints = [ leadingConstraint, trailingConstraint, topConstraint, bottomConstraint ]
        self.addConstraints(constraints)
        
        return constraints
    }
}








extension UIView{
    @discardableResult
    func leadingConstraint(_ item: UIView) -> NSLayoutConstraint{
        return NSLayoutConstraint(
            item: item,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        )
    }
    
    @discardableResult
    func trailingConstraint(_ item: UIView) -> NSLayoutConstraint{
        return NSLayoutConstraint(
            item: item,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        )
    }
    
    @discardableResult
    func topConstraint(_ item: UIView, attribute: NSLayoutAttribute, constant: CGFloat = 0) -> NSLayoutConstraint{
        let constraint = NSLayoutConstraint(
            item: item,
            attribute: attribute,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: constant
        )
        return constraint
    }
    
    @discardableResult
    func bottomConstraint(_ item: UIView) -> NSLayoutConstraint{
        return NSLayoutConstraint(
            item: item,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
    }
    
    @discardableResult
    func heightEqualConstraint(_ item: UIView) -> NSLayoutConstraint{
        let constraint = NSLayoutConstraint(
            item: item,
            attribute: .height,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: 1,
            constant: 0
        )
        return constraint
    }
    
    @discardableResult
    func heightConstraint(_ constant: CGFloat) -> NSLayoutConstraint{
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: constant
        )
        return constraint
    }
}

extension CGFloat{
    var abs: CGFloat{
        return self >= 0 ? self : -self
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(hexString: String) {
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
