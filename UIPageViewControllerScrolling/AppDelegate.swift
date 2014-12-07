//
//  AppDelegate.swift
//  UIPageViewControllerScrolling
//
//  Created by Pilipenko Dima on 07.12.14.
//  Copyright (c) 2014 Pilipenko Dima. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow!
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = UIColor.whiteColor()
        window.makeKeyAndVisible()
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor()
        
        window.rootViewController = ExampleUIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        
        return true
    }
}

