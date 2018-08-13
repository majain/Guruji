//
//  EventsViewController.swift
//  Sample
//
//  Created by Jain, Mohit on 8/6/18.
//  Copyright © 2018 Handsome. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import WebKit

class EventsViewController: UIViewController , WKNavigationDelegate, SideMenuItemContent, Storyboardable {
    var webView: WKWebView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        showSideMenu()
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        let url = URL(string: "http://www.sribrahmrishiashram.org/events")!
        webView.load(URLRequest(url: url))
        
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}


