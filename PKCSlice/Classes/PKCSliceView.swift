//
//  PKCSliceView.swift
//  Pods
//
//  Created by guanho on 2017. 4. 16..
//
//

import UIKit

protocol PKCSliceViewDelegate {
    func pkcSliceViewGesture(_ index: Int, isCurrentView: Bool)
}

open class PKCSliceView: UIView {
    
    //MARK: property
    var index: CGFloat = 0
    var count: CGFloat = 0
    var inclination: CGFloat = 0
    var inclinationTop: CGFloat = 0
    var inclinationBottom: CGFloat = 0
    
    var delegate: PKCSliceViewDelegate?
    
    
    //MARK: init
    
    //inclination
    init(_ index: Int, count: Int, inclination: CGFloat) {
        super.init(frame: CGRect.zero)
        self.setData(index, count: count)
        self.inclination = inclination
    }
    
    
    //inclinationTop, inclinationBottom
    init(_ index: Int, count: Int, inclinationTop: CGFloat, inclinationBottom: CGFloat) {
        super.init(frame: CGRect.zero)
        self.initData(index, count: count, inclinationTop: inclinationTop, inclinationBottom: inclinationBottom)
    }
    
    //스토리보드에서 만들었을 경우 PKCSliceView가 해당 메서드 호출
    func initData(_ index: Int, count: Int, inclinationTop: CGFloat, inclinationBottom: CGFloat){
        self.setData(index, count: count)
        self.inclinationTop = inclinationTop
        self.inclinationBottom = inclinationBottom
    }
    
    
    //Add Gesture
    func setData(_ index: Int, count: Int){
        self.count = CGFloat(count)
        self.index = CGFloat(index)
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(self.buttonTouch(_:))
        )
        self.addGestureRecognizer(tapGesture)
    }
    
    
    //영역 자르기
    func setSliceFrame(y: CGFloat, width: CGFloat, height: CGFloat){
        self.setRect(y: y, width: width, height: height)
        self.setBezierPath(width: width, height: height)
    }
    
    
    //frame
    func setRect(y: CGFloat, width: CGFloat, height: CGFloat){
        self.frame = CGRect(
            x: 0,
            y: y - CGFloat(abs(self.inclination)),
            width: width,
            height: height + CGFloat(abs(self.inclination))*2
        )
    }
    
    
    //mask
    fileprivate func setBezierPath(width: CGFloat, height: CGFloat){
        let layer = CAShapeLayer()
        let bezierPath = PKCBezierPath(
            self.index,
            count: self.count,
            inclination: self.inclination,
            width: width,
            height: height
        )
        layer.path = bezierPath.cgPath
        self.layer.mask = layer
    }
    
    
    //mask 스토리보드로 만들었을때 사용
    func setBezierPathDiff(width: CGFloat, height: CGFloat){
        let layer = CAShapeLayer()
        let bezierPath = PKCBezierPath(
            self.index,
            count: self.count,
            inclinationTop: self.inclinationTop,
            inclinationBottom: self.inclinationBottom,
            width: width,
            height: height
        )
        layer.path = bezierPath.cgPath
        self.layer.mask = layer
    }
    
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    //터치
    @objc private func buttonTouch(_ sender: UITapGestureRecognizer){
        let touchLocation: CGPoint = sender.location(in: sender.view)
        guard let isCurrentView = (self.layer.mask as? CAShapeLayer)?.path?.contains(touchLocation) else{
            return
        }
        self.delegate?.pkcSliceViewGesture(Int(self.index), isCurrentView: isCurrentView)
    }
}
