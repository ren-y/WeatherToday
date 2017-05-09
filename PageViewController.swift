//
//  PageViewController.swift
//  WeatherToday
//
//  Created by reena on 07/05/17.
//  Copyright © 2017 Reena. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    var forecast = [Forecast]()
    var passSignalToHideButtonInContentVC : Bool = false
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        self.configurePageControl()
        let initialContenViewController = self.pageTutorialAtIndex(0) as ViewController
        self.setViewControllers([initialContenViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }
    
    func pageTutorialAtIndex(_ index: Int) ->ViewController
    {
        
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContent") as! ViewController
        
        if forecast.count == 0 {
            
            pageContentViewController.pageIndex = 0
            print("Forecast \(forecast.count)")
            return pageContentViewController
        }else {
            print("in function appear \(self.forecast.count)")
            let forecast = self.forecast[index]
            pageContentViewController.forecast = forecast
            pageContentViewController.pageIndex = index
            pageContentViewController.hideFavButton = passSignalToHideButtonInContentVC
            
            return pageContentViewController
            
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! ViewController
        var index = viewController.pageIndex as Int
        pageControl.currentPage = index //move dot
        if(index == 0 || index == NSNotFound)
        {
            return nil
        }
        
        index -= 1
        
        return self.pageTutorialAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let viewController = viewController as! ViewController
        var index = viewController.pageIndex as Int
        pageControl.currentPage = index //move dot
        if((index == NSNotFound))
        {
            return nil
        }
        
        index += 1
        
        if(index == forecast.count)
        {
            return nil
        }
        
        return self.pageTutorialAtIndex(index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return forecast.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    func configurePageControl() {
        
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 100,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.brown
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
}


