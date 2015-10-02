//
//  AppDelegate.swift
//  UIPageViewControllerScrolling
//
//  Created by Pilipenko Dima on 07.12.14.
//  Copyright (c) 2014-2015 Pilipenko Dima. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.backgroundColor = UIColor.whiteColor()
        window!.makeKeyAndVisible()
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor()
        
        let sliderVC = SliderViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        sliderVC.sliderConfig = SliderConfig(bounces: false, defaultSlide: .Two, showDefaultPageIndicator: true, sendDefaultSlideChange: true)
        
        /* Here you can add view controllers at external side
        sliderVC.applyController { type in
            switch type {
                case .One: return FirstViewController()
                case .Two: return SecondViewController()
                case .Three: return ThirdViewController()
            }
        }*/
        
        sliderVC.didChangedSlide { value in
            print("current slide: \(value)")
        }
        
        window!.rootViewController = sliderVC
        
        return true
    }
}