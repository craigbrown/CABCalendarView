# CABCalendar

[![CI Status](http://img.shields.io/travis/Craig/CABCalendar.svg?style=flat)](https://travis-ci.org/Craig/CABCalendar)
[![Version](https://img.shields.io/cocoapods/v/CABCalendar.svg?style=flat)](http://cocoapods.org/pods/CABCalendar)
[![License](https://img.shields.io/cocoapods/l/CABCalendar.svg?style=flat)](http://cocoapods.org/pods/CABCalendar)
[![Platform](https://img.shields.io/cocoapods/p/CABCalendar.svg?style=flat)](http://cocoapods.org/pods/CABCalendar)

An iOS calendar view component with vertical scrolling and auto-layout support.

![alt text](https://github.com/Frakur/CABCalendar/raw/master/Screenshot.png "CABCalendarView example")

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

CABCalendar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CABCalendar"
```

## Author

Craig, craigbrown24@gmail.com

## License

CABCalendar is available under the MIT license. See the LICENSE file for more info.
