//
//  ViewController.swift
//  Mobblr
//
//  Created by Mohit Mishra on 12/28/15.
//  Copyright © 2015 Mohit Mishra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageHTMLString: NSArray!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //var titles = NSArray(objects: "Post 1", "Post 2", "Post 3")
        let imageContent = NSArray(objects: "https://sarahzaki.files.wordpress.com/2012/03/mobile-blogging-1.jpg", "https://w3layouts.com/wp-content/uploads/2015/07/coffee_break.jpg","http://ivinviljoen.net/wp-content/uploads/2014/11/top-10-mobile-blogging-tools-3-638_phixr.jpg")
        //let imageContent = NSArray(objects: "image1", "image2", "image3")
        let textContent = NSArray(objects: "<h1>Welcome to Mobblr</h1>", "<h1>Blogging on the Go</h1>", "<h1>Brand your blog</h1")
        self.pageHTMLString = NSArray(objects: "<img src=\""+(imageContent[0] as! String) + "\"<br>"+(textContent[0] as! String),"<img src=\""+(imageContent[1] as! String)+"\"<br>"+(textContent[1] as! String),"<img src=\""+(imageContent[2] as! String)+"\"<br>"+(textContent[2] as! String))
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func viewControllerAtIndex(index: Int) -> ContentViewController
    {
        if ((self.pageHTMLString.count == 0) || (index >= self.pageHTMLString.count)) {
            return ContentViewController()
        }
        
        let vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController

        vc.pageIndex = index
        vc.HTMLString = self.pageHTMLString[index] as! String
        
        return vc
        
        
    }
    
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        
        var vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        
        if (index == 0 || index == NSNotFound)
        {
            return nil
            
        }
        
        index--
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound)
        {
            return nil
        }
        
        index++
        
        if (index == self.pageHTMLString.count)
        {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    /*func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
    return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
    return 0
    }*/
    
}



