//
//  ContentViewController.swift
//  Mobblr
//
//  Created by Mohit Mishra on 12/28/15.
//  Copyright © 2015 Mohit Mishra. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var pageIndex: Int!
    var HTMLString: String!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.webView.scrollView.scrollEnabled = true
        self.webView.scalesPageToFit = true
        self.webView.loadHTMLString(self.HTMLString, baseURL: nil)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
