//
//  ExampleUIPageViewController.swift
//  UIPageViewControllerScrolling
//
//  Created by Pilipenko Dima on 07.12.14.
//  Copyright (c) 2014 Pilipenko Dima. All rights reserved.
//

import Foundation
import UIKit

class ExampleUIPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    private var _controllerEnum: ControllerEnum = ControllerEnum()
    private var _dict: [UIViewController: ControllerEnum] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        setViewControllers([getController(_controllerEnum)!], direction: .Forward, animated: false, completion: nil)
    }
    
    // *** PROTOCOLS
    // UIPageViewControllerDataSource
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return ControllerEnum.allValues.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return _controllerEnum.rawValue
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return getController(_dict[viewController]!.prevIndex())
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return getController(_dict[viewController]!.nextIndex())
    }
    
    // *** PRIVATE METHODS
    private func getController(value: ControllerEnum) -> UIViewController? {
        var vc: UIViewController?
        switch value {
            case .Credits:
                vc = UIViewController()
                vc!.view.backgroundColor = UIColor.redColor()
                
            case .Center:
                vc = UIViewController()
                vc!.view.backgroundColor = UIColor.greenColor()
                
            case .Debts:
                vc = UIViewController()
                vc!.view.backgroundColor = UIColor.blueColor()
                
            default: return nil
        }
        // store relative enum to view controller
        _dict[vc!] = value
        return vc!
    }
}

private enum ControllerEnum: Int {
    static let allValues = [Credits, Center, Debts]
    
    case Nil = -1, Credits, Center, Debts
    
    init() {
        self = .Center
    }
    
    func prevIndex() -> ControllerEnum {
        return ControllerEnum(rawValue: rawValue-1)!
    }
    
    func nextIndex() -> ControllerEnum {
        var value = rawValue+1
        if value > ControllerEnum.allValues.count-1 { value = Nil.rawValue }
        return ControllerEnum(rawValue: value)!
    }
}