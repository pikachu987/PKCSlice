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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.editAction(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addAction(_:)))
        
        
        // delegate
        self.sliceView.delegate = self
        // appends
        self.sliceView.append(contentsOf: [
            PKCSliceImageView(image: UIImage(named: "1.png")),
            PKCSliceImageView(image: UIImage(named: "2.png"))
            ])
        
        
        
        
        
        
        // Make SliceView in Code Editor Example
        
//        let sliceView = PKCSlice()
//        self.view.addSubview(sliceView)
//        sliceView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addConstraint(NSLayoutConstraint(
//            item: self.view,
//            attribute: .leading,
//            relatedBy: .equal,
//            toItem: sliceView,
//            attribute: .leading,
//            multiplier: 1,
//            constant: 0)
//        )
//        self.view.addConstraint(NSLayoutConstraint(
//            item: self.view,
//            attribute: .trailing,
//            relatedBy: .equal,
//            toItem: sliceView,
//            attribute: .trailing,
//            multiplier: 1,
//            constant: 0)
//        )
//        self.view.addConstraint(NSLayoutConstraint(
//            item: self.view,
//            attribute: .top,
//            relatedBy: .equal,
//            toItem: sliceView,
//            attribute: .top,
//            multiplier: 1,
//            constant: 0)
//        )
//        self.view.addConstraint(NSLayoutConstraint(
//            item: self.view,
//            attribute: .bottom,
//            relatedBy: .equal,
//            toItem: sliceView,
//            attribute: .bottom,
//            multiplier: 1,
//            constant: 0)
//        )
//        sliceView.append(contentsOf: [
//            PKCSliceImageView(image: UIImage(named: "1.png")),
//            PKCSliceImageView(image: UIImage(named: "2.png")),
//            PKCSliceImageView(image: UIImage(named: "3.png")),
//            PKCSliceImageView(image: UIImage(named: "4.png")),
//            PKCSliceImageView(image: UIImage(named: "1.png"))
//            ])
    }

    
    
    
    
    
    
    @objc private func editAction(_ sender: UIBarButtonItem){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Top & Bottom Fill On&Off", style: .default, handler: { (_) in
            
            
            // top & bottom fill
            self.sliceView.isTopFill = !self.sliceView.isTopFill
            self.sliceView.isBottomFill = !self.sliceView.isBottomFill
            
            
        }))
        
        
        
        alertController.addAction(UIAlertAction(title: "Top & Bottom View", style: .default, handler: { (_) in
            
            
            
            // top & bottom sliceView
            
            if self.sliceView.topSliceView == nil{
                self.sliceView.topSliceView = PKCSliceImageView(image: UIImage(named: "temp.png"))
            }else{
                self.sliceView.topSliceView = nil
            }
            
            if self.sliceView.bottomSliceView == nil{
                self.sliceView.bottomSliceView = PKCSliceImageView(image: UIImage(named: "temp.png"))
            }else{
                self.sliceView.bottomSliceView = nil
            }
            
            
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    @objc private func addAction(_ sender: UIBarButtonItem){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Default Add", style: .default, handler: { (_) in
            
            
            // Default Append
            if self.sliceView.sliceViewArray.count % 4 == 0{
                self.sliceView.append(PKCSliceImageView(image: UIImage(named: "1.png")))
            }else if self.sliceView.sliceViewArray.count % 4 == 1{
                self.sliceView.append(PKCSliceImageView(image: UIImage(named: "2.png")))
            }else if self.sliceView.sliceViewArray.count % 4 == 2{
                self.sliceView.append(PKCSliceImageView(image: UIImage(named: "3.png")))
            }else if self.sliceView.sliceViewArray.count % 4 == 3{
                self.sliceView.append(PKCSliceImageView(image: UIImage(named: "4.png")))
            }
            
            
        }))
        alertController.addAction(UIAlertAction(title: "Xib Custom Add", style: .default, handler: { (_) in
            
            
            
            // CustomSliceView Append
            guard let sliceView = Bundle.main.loadNibNamed("CustomSliceView", owner: self, options: nil)?.first as? CustomSliceView else{
                return
            }
            self.sliceView.append(sliceView)
            
            
            
        }))
        alertController.addAction(UIAlertAction(title: "RemoveAll", style: .destructive, handler: { (_) in
            
            
            // remove All
            self.sliceView.removeAll()
            
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        // inclination
        self.sliceView.inclination = CGFloat(sender.value)
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}







extension ViewController: SliceDelegate{
    
    
    
    
    
    func sliceTouchAction(_ slice: PKCSlice, sliceView: PKCSliceView?, index: Int) {
        guard let sliceView = sliceView else { return }
        let alertController = UIAlertController(title: "sliceView index: \(index)", message: "\(sliceView)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    func sliceTopTouchAction(_ slice: PKCSlice, sliceView: PKCSliceView) {
        let alertController = UIAlertController(title: "top sliceView", message: "\(sliceView)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    func sliceBottomTouchAction(_ slice: PKCSlice, sliceView: PKCSliceView) {
        let alertController = UIAlertController(title: "bottom sliceView", message: "\(sliceView)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

