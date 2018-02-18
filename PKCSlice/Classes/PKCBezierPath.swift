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

// BezierPath
class PKCBezierPath: UIBezierPath{
    
    // MARK: Initializers
    
    
    init(
        index: Int,
        count: CGFloat,
        inclination: CGFloat,
        isTopFill: Bool,
        isBottomFill: Bool,
        size: CGSize) {
        super.init()
        
        let isFirst = index == 0
        let isLast = index == Int(count-1)
        
        let isTop = (isTopFill && isFirst)
        let isBottom = (isBottomFill && isLast)
        
        if inclination >= 0{
            self.move(to: CGPoint(x: 0, y: 0))
            self.addLine(to: CGPoint(x: size.width, y: isTop ? 0 : inclination))
            self.addLine(to: CGPoint(x: size.width, y: size.height-inclination/count))
            let y = size.height-inclination-inclination/count
            self.addLine(to: CGPoint(x: 0, y: isBottom ? size.height : y))
        }else{
            let remainderInclination = inclination/count*(count-1)
            self.move(to: CGPoint(x: 0, y: isTop ? 0 : -inclination))
            self.addLine(to: CGPoint(x: size.width, y: 0))
            self.addLine(to: CGPoint(x: size.width, y: isBottom ? size.height-inclination-remainderInclination : size.height-remainderInclination))
            self.addLine(to: CGPoint(x: 0, y: size.height-inclination-remainderInclination))
        }
    }
    
    
    
    
    init(
        topCount: CGFloat,
        inclination: CGFloat,
        size: CGSize) {
        super.init()
        
        if inclination >= 0{
            self.move(to: CGPoint(x: 0, y: 0))
            self.addLine(to: CGPoint(x: size.width, y: 0))
            self.addLine(to: CGPoint(x: size.width, y: inclination))
            self.addLine(to: CGPoint(x: 0, y: 0))
        }else{
            self.move(to: CGPoint(x: 0, y: 0))
            self.addLine(to: CGPoint(x: size.width, y: 0))
            self.addLine(to: CGPoint(x: 0, y: -inclination))
            self.addLine(to: CGPoint(x: 0, y: 0))
        }
    }
    
    init(
        bottomCount: CGFloat,
        inclination: CGFloat,
        size: CGSize) {
        super.init()
        
        if inclination >= 0{
            let y = size.height-inclination-inclination/bottomCount
            self.move(to: CGPoint(x: 0, y: y))
            self.addLine(to: CGPoint(x: size.width, y: size.height-inclination/bottomCount))
            self.addLine(to: CGPoint(x: 0, y: size.height-inclination/bottomCount))
            self.addLine(to: CGPoint(x: 0, y: y))
        }else{
            let remainderInclination = inclination/bottomCount*(bottomCount-1)
            self.move(to: CGPoint(x: 0, y: size.height-inclination-remainderInclination))
            self.addLine(to: CGPoint(x: size.width, y: size.height-remainderInclination))
            self.addLine(to: CGPoint(x: size.width, y: size.height-inclination-remainderInclination))
            self.addLine(to: CGPoint(x: 0, y: size.height-inclination-remainderInclination))
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
