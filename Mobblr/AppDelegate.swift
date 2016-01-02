//
//  AppDelegate.swift
//  Mobblr
//
//  Created by Mohit Mishra on 12/28/15.
//  Copyright © 2015 Mohit Mishra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var images: [String] = []
    var bodies: [String] = []

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // Testing Alamofire
        
        
        let parameters = ["count": 100]
        Alamofire.request(.POST, "http://104.131.97.176:8000/lastn/", parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let post = JSON(value)
                    print(post)
                    if let postsArray = response.result.value as? NSArray {
                        for index in 0..<postsArray.count {
                            if let body = postsArray[index] as? NSDictionary {
                                if let image = body["image_url"] as? String {
                                    self.images.append(image)
                                } else {
                                    self.images.append("")
                                }
                                if let content = body["html_body"] as? String {
                                    self.bodies.append(content)
                                } else {
                                    self.bodies.append("")
                                }
                            }
                            
                        }
                        
                    }
                    
                }
        }
        
        var pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

