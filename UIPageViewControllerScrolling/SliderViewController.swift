//
//  SliderViewController.swift
//  UIPageViewControllerScrolling
//
//  Created by Pilipenko Dima on 07.12.14.
//  Copyright (c) 2014-2015 Pilipenko Dima. All rights reserved.
//

import Foundation
import UIKit

class SliderViewController: UIPageViewController, UIPageViewControllerDataSource, UIScrollViewDelegate {
    var sliderConfig: SliderConfig? {
        didSet {
            _currentSlide = sliderConfig!.defaultSlide
        }
    }
    
    private var _currentSlide: Slide = .One
    var currentSlide: Slide {
        return _currentSlide
    }
    
    private var _applyControllerCallback: (Slide -> UIViewController)?
    private var _didChangedSlideCallback: (Slide -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        (view.subviews.first as? UIScrollView)?.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setViewControllers([getController(currentSlide)], direction: .Forward, animated: true, completion: nil)
        
        if sliderConfig?.sendDefaultSlideChange == true {
            _didChangedSlideCallback?(_currentSlide)
        }
    }
   
    // *** METHODS
    // * FUNCTIONS
    func applyController(callback: Slide -> UIViewController) {
        _applyControllerCallback = callback
    }
    
    func didChangedSlide(callback: Slide -> Void) {
        _didChangedSlideCallback = callback
    }
    
    // PRIVATE
    private func getController(type: Slide?) -> UIViewController! {
        guard let type = type else { return nil }
        
        let viewController: UIViewController
        if let callback = _applyControllerCallback {
            viewController = callback(type)
        }
        else {
            let color: UIColor
            switch type {
                case .One: color = UIColor(red: 0.27, green: 0.22, blue: 0.11, alpha: 1)
                case .Two: color = UIColor(red: 0.4, green: 0.58, blue: 0.27, alpha: 1)
                case .Three: color = UIColor(red: 0.9, green: 1, blue: 0.83, alpha: 1)
            }
            
            viewController = UIViewController()
            viewController.view.backgroundColor = color
        }
        
        Slide.linkWith(viewController, slide: type)
        return viewController
    }
    
    // * DELEGATES
    // UIPageViewControllerDataSource
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return sliderConfig?.showDefaultPageIndicator == false ? 1 : Slide.allValues.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentSlide.rawValue
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return getController(Slide.getLinked(viewController).prev())
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return getController(Slide.getLinked(viewController).next())
    }
    
    // UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.bounces = sliderConfig?.bounces ?? true
        
        guard let vc = viewControllers?[0], case let slide = Slide.getLinked(vc) where slide != _currentSlide else { return }
        
        _currentSlide = slide
        _didChangedSlideCallback?(_currentSlide)
    }
}

enum Slide: Int {
    case One, Two, Three
    
    static let allValues = [One, Two, Three]
    static private var _storage: [UIViewController: Slide] = [:]
    
    private func prev() -> Slide? {
        return Slide(rawValue: rawValue-1)
    }
    
    private func next() -> Slide? {
        return Slide(rawValue: rawValue+1)
    }
    
    private static func linkWith(value: UIViewController, slide: Slide) {
        _storage[value] = slide
    }
    
    private static func getLinked(value: UIViewController) -> Slide {
        return _storage[value]!
    }
}

struct SliderConfig {
    let bounces: Bool
    let defaultSlide: Slide
    let showDefaultPageIndicator: Bool
    let sendDefaultSlideChange: Bool

    init(bounces: Bool, defaultSlide: Slide, showDefaultPageIndicator: Bool, sendDefaultSlideChange: Bool = false) {
        self.bounces = bounces
        self.defaultSlide = defaultSlide
        self.showDefaultPageIndicator = showDefaultPageIndicator
        self.sendDefaultSlideChange = sendDefaultSlideChange
    }
}