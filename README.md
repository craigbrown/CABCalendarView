# CABCalendarView

[![CI Status](http://img.shields.io/travis/craig/CABCalendarView.svg?style=flat)](https://travis-ci.org/craig/CABCalendarView)
[![Version](https://img.shields.io/cocoapods/v/CABCalendarView.svg?style=flat)](http://cocoapods.org/pods/CABCalendarView)
[![License](https://img.shields.io/cocoapods/l/CABCalendarView.svg?style=flat)](http://cocoapods.org/pods/CABCalendarView)
[![Platform](https://img.shields.io/cocoapods/p/CABCalendarView.svg?style=flat)](http://cocoapods.org/pods/CABCalendarView)

An iOS calendar view component with vertical scrolling and auto-layout support.

![alt text](https://github.com/Frakur/CABCalendarView/raw/master/Screenshot.gif "CABCalendarView example")

## Why use CABCalendarView?

- Vertical scrolling!
- Mark events on specific days!
- Familiar data source/delegate pattern!
- Well documented!
- Integration with Xcode Interface Builder (IBDesignable)!
- All dates in the past and future fully implemented!

I've also [written an article with more details](http://craig24.com/cabcalendarview-for-ios/) on my website. Check it out!

## Usage

You might want to start by taking a look at the example project. To run the example project, clone the repo, and run `pod install` from the Example directory first.

The easiest way to use CABCalendarView is through Interface Builder. 

1. Add a new view to your view controller.
2. Set the class of this view to be a CABCalendarView type.
3. Set the row height attribute as required, or leave it at the default (44pts).
4. Ensure the height is 6x the row height, so that eactly six rows will be shown.
5. Set up constraints for the view as required.

You should also set a data source and delegate and implement these methods to get the most out of this component. 

## Installation

CABCalendarView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CABCalendarView"
```

## Author

craig, [@CraigAB24](https://twitter.com/CraigAB24)

## License

CABCalendarView is available under the MIT license. See the LICENSE file for more info.
