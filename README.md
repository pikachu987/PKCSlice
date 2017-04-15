# PKCSlice


[![Version](https://img.shields.io/cocoapods/v/PKCSlice.svg?style=flat)](http://cocoapods.org/pods/PKCSlice)
[![License](https://img.shields.io/cocoapods/l/PKCSlice.svg?style=flat)](http://cocoapods.org/pods/PKCSlice)
[![Platform](https://img.shields.io/cocoapods/p/PKCSlice.svg?style=flat)](http://cocoapods.org/pods/PKCSlice)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

#### use storyboard

![image](./1.png)

![image](./2.png)

![image](./s_1.png)

![image](./s_2.png)

![image](./s_3.png)

~~~~

@IBOutlet weak var sliceView: PKCSlice!

self.sliceView.delegate = self
//self.sliceView.autoSlice(false)


extension ViewController: PKCSliceDelegate{
    func pkcSliceTouch(_ index: Int) {
        
    }
}

~~~~

<br><br><br><br><br><br>

#### use code

![image](./3.png)


~~~~

var images = [UIImage]()
images.append(UIImage(named: "4.png")!)
images.append(UIImage(named: "3.png")!)
images.append(UIImage(named: "2.png")!)
images.append(UIImage(named: "1.png")!)
let sliceView = PKCSlice(self.superView, sliceImages: images)

~~~~


<br><br><br><br><br><br>

#### touch Delegate

![image](./4.png)

![image](./5.png)


~~~~~

public protocol PKCSliceDelegate {
    func pkcSliceTouch(_ index: Int)
}

~~~~~


## Requirements

## Installation

PKCSlice is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PKCSlice"
```

## Author

pikachu987, pikachu77769@gmail.com

## License

PKCSlice is available under the MIT license. See the LICENSE file for more info.
