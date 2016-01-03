//
//  ViewController.swift
//  Mobblr
//
//  Created by Mohit Mishra on 12/28/15.
//  Copyright © 2015 Mohit Mishra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageHTMLString = [String]()
    var observer: NSObjectProtocol?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        observer = NSNotificationCenter.defaultCenter().addObserverForName("imagesNotificationKey", object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let imageContent = delegate.images
            let textContent = delegate.bodies
            let titleContent = delegate.titles

            for index in 0..<imageContent.count {
                self.pageHTMLString.append("<img src=\""+(imageContent[index]) + "\"<br><strong><h2>"+titleContent[index]+"</h2></strong><br>"+(textContent[index]))
            }
            
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
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(observer!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func viewControllerAtIndex(index: Int) -> ContentViewController
    {
        //print (self.pageHTMLString.count)
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
    func preloadData() -> [String]{
        var images = [String]()
        let parameters = ["count": 100]
        Alamofire.request(.POST, "http://104.131.97.176:8000/lastn/", parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let posts = JSON(value)
                    //print(posts)
                    for index in 0..<posts.count {
                        //print(posts[index]["image_url"])
                        if let image = posts[index]["image_url"].string {
                            images += [image]
                            print(images[index])
                            
                        } else {
                            images += [""]
                        }
                    }
                    
                    
                }
                
        }
        return images
        
    }

    
}



