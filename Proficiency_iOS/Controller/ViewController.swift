//
//  ViewController.swift
//  Proficiency_iOS
//
//  Created by Prince Gupta on 15/02/20.
//  Copyright © 2020 Prince Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        apiCall()
    }
    
    func apiCall() {
        
        let appUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        
        let session = URLSession.shared
        let url = URL(string: appUrl)!
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        
        session.dataTask(with: req) { (data, resp, err) in
            
            guard err == nil else {
                return
            }
            
            let str2 = String(data: data!, encoding: .isoLatin1)
            //print(str2)
                        
            let data2 = str2?.data(using: .utf8)
            // Serialize the data into an object
            do {
                let json = try JSONDecoder().decode(ResponseModel.self, from: data2!)
                print(json)
            } catch {
                print(error)
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }.resume()
    }
    
}



