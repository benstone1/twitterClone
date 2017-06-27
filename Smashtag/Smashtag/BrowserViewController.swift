//
//  BrowserViewController.swift
//  Smashtag
//
//  Created by C4Q  on 6/26/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController {
    
    var url: URL? {
        didSet {
            if view.window != nil {
                loadWebsite()
            }
        }
    }
    
    func loadWebsite() {
        webView.loadRequest(URLRequest(url: url!))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebsite()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var webView: UIWebView!


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
