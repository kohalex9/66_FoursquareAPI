//
//  WebViewController.swift
//  66_FourSquareAPI
//
//  Created by Alex Koh on 06/09/2017.
//  Copyright © 2017 AlexKoh. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var selectedRestaurant: Restaurant?

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let url = selectedRestaurant?.urlString {
            loadTheUrl(with: url)
            print(url)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func loadTheUrl(with String: String) {
        guard let url = URL(string: String) else {
            print("Invalid string: \(String)")
            return
        }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
}

extension WebViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("Start loading")
        loadingView.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Finish loading")
        loadingView.stopAnimating()
    }
    
    
}













