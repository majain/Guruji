//
//  VideoWebController.swift
//  Sample
//
//  Created by Jain, Mohit on 8/5/18.
//  Copyright © 2018 Handsome. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import WebKit

class VideoWebController: UIViewController, WKNavigationDelegate, SideMenuItemContent, Storyboardable {
    var webView: WKWebView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        showSideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWeb()
    }
    
    func loadWeb() {
        // 1
        let url = URL(string: "https://www.youtube.com/results?search_query=guruvanand+swami+ji")!
        webView.load(URLRequest(url: url))
        
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
        
    }
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // webView.frame = CGRect(x: 0, y: -500, width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = String("Guruji Video's")
        let scrollPoint = CGPoint(x: 0, y: 25)
        webView.scrollView.setContentOffset(scrollPoint, animated: true)//Set false if you doesn't want animation

    }
}

