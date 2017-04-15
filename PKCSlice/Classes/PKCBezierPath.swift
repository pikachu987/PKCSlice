//
//  PKCBezierPath.swift
//  Pods
//
//  Created by guanho on 2017. 4. 16..
//
//

import UIKit

class PKCBezierPath: UIBezierPath{
    
    //기울기 동일
    init(_ index: CGFloat, count: CGFloat, inclination: CGFloat, width: CGFloat, height: CGFloat) {
        super.init()
        
        var movePt = CGPoint()
        var add1Pt = CGPoint()
        var add2Pt = CGPoint()
        var add3Pt = CGPoint()
        
        if inclination > 0{
            movePt = CGPoint(x: 0, y: 0)
            add1Pt = CGPoint(x: width, y: index == 0 ? 0 : inclination*2)
            add2Pt = CGPoint(x: width, y: height+inclination*2)
            add3Pt = CGPoint(x: 0, y: index == count-1 ? height+inclination*2 : height)
        }else{
            movePt = CGPoint(x: 0, y: index == 0 ? 0 : -inclination*2)
            add1Pt = CGPoint(x: width, y: 0)
            add2Pt = CGPoint(x: width, y: index == count-1 ? height-inclination*2 : height)
            add3Pt = CGPoint(x: 0, y: height-inclination*2)
        }
        
        self.move(to: movePt)
        self.addLine(to: add1Pt)
        self.addLine(to: add2Pt)
        self.addLine(to: add3Pt)
    }
    
    //뷰마다 기울기 다를떄
    init(_ index: CGFloat, count: CGFloat, inclinationTop: CGFloat, inclinationBottom: CGFloat, width: CGFloat, height: CGFloat) {
        super.init()
        
        var movePt = CGPoint()
        var add1Pt = CGPoint()
        var add2Pt = CGPoint()
        var add3Pt = CGPoint()
        
        if index == 0{
            
        }
        if inclinationTop > 0{
            movePt = CGPoint(x: 0, y: 0)
            add1Pt = CGPoint(x: width, y: index == 0 ? 0 : inclinationTop*2)
        }else{
            movePt = CGPoint(x: 0, y: index == 0 ? 0 : -inclinationTop*2)
            add1Pt = CGPoint(x: width, y: 0)
        }
        if inclinationBottom > 0{
            add2Pt = CGPoint(x: width, y: height+inclinationBottom*2)
            add3Pt = CGPoint(x: 0, y: index == count-1 ? height+inclinationBottom*2 : height)
        }else{
            add2Pt = CGPoint(x: width, y: index == count-1 ? height-inclinationBottom*2 : height)
            add3Pt = CGPoint(x: 0, y: height-inclinationBottom*2)
        }
        
        self.move(to: movePt)
        self.addLine(to: add1Pt)
        self.addLine(to: add2Pt)
        self.addLine(to: add3Pt)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
