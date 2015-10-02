####[Swift] UIPageViewControllerScrolling
#####Source code of realization page scrolling using UIPageViewController as base class, with configuration and predefined enum cases of each page(next: slide)

Updated to Swift 2

Features:
* disable/enable bounces on edges
* detect slide change
* external apply of view controllers for each slide

Usage:

Configuration has: 
```
struct SliderConfig {
    let bounces: Bool
    let defaultSlide: Slide
    let showDefaultPageIndicator: Bool
    let sendDefaultSlideChange: Bool
    ...
```

"View controllers" can be defined for each case externally:
```
...
sliderVC.applyController { type in
  switch type {
    case .One: return FirstViewController()
    case .Two: return SecondViewController()
    case .Three: return ThirdViewController()
  }
}
...
```

######Full code at AppDelegate.swift
