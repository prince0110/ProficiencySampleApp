//
//  ViewController.swift
//  Proficiency_iOS
//
//  Created by Prince Gupta on 15/02/20.
//  Copyright © 2020 Prince Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var customTableView = UITableView()
    var itemsArray: [ItemDict]?
    var refreshControl = UIRefreshControl()
    var downloadedImageUrls = [String: UIImage?]()

    override func viewDidLoad() {

        super.viewDidLoad()

        self.configureTableView()
        self.apiCall()
    }

    func configureTableView() {
        
        let tableFrame = CGRect(x: 0, y: 44, width: 375, height: 623)
        self.customTableView = UITableView(frame: tableFrame)
        self.customTableView.dataSource = self
        self.customTableView.delegate = self
        self.view.addSubview(self.customTableView)
        
        self.customTableView.translatesAutoresizingMaskIntoConstraints = false

        let safeGuide = self.view.safeAreaLayoutGuide
        self.customTableView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        self.customTableView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        self.customTableView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        self.customTableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true

        self.customTableView.register(UINib.init(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCellIdentifier")
        self.customTableView.estimatedRowHeight = 10
        self.customTableView.rowHeight = UITableView.automaticDimension

        //Pull to refresh
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        self.customTableView.addSubview(refreshControl)
    }

    @objc func refresh(sender:AnyObject) {

        // Code to refresh table view
        self.apiCall()
        self.refreshControl.endRefreshing()
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
            let data2 = str2?.data(using: .utf8)

            // Serialize the data into an object
            do {
                let json = try JSONDecoder().decode(ResponseModel.self, from: data2!)
                
                OperationQueue.main.addOperation({
                    let titleString = json.mainTitle!
                    self.updateNavBar(with: titleString)
                    self.itemsArray = json.items
                    self.updateTableView()
                })
            } catch {
                
                print(error)
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }.resume()
    }

    func updateNavBar(with title: String) {

        self.title = title
    }


    func updateTableView() {

        self.customTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.itemsArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCellIdentifier", for: indexPath) as! CustomTableViewCell

        let itemDict = self.itemsArray![indexPath.row]

        //Set Title
        if let titleText = itemDict.title {
            cell.titleLbl.text = titleText
        } else  {
            cell.titleLbl.text = "Title Missing"
        }

        //Set Description
        if let descriptionText = itemDict.desc {
            cell.descriptionLbl.text = descriptionText
        } else  {
            cell.descriptionLbl.text = "Description Missing"
        }

        //Set Image
        cell.imgView.image = nil

        if let itemURLString = itemDict.imageUrl {
            let key = URL(string: itemURLString)!.path
            if self.downloadedImageUrls.keys.contains(key) &&
                self.downloadedImageUrls[key] != nil {
                cell.imgView.image = self.downloadedImageUrls[key]!
            } else {
                let url = URL(string: itemURLString)
                downloadImage(from: url!) { img in
                    if let validImage = img {
                        cell.imgView.image = validImage
                    } else {
                        cell.imgView.image = UIImage.init(named: "PlaceholderImage.jpg")
                    }
                }
            }
        } else {
            cell.imgView.image = UIImage.init(named: "PlaceholderImage.jpg")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension ViewController {

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL, completion: @escaping (UIImage?)->Void) {

        let key = url.path

        getData(from: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }

            DispatchQueue.main.async() {

                let image = UIImage(data: data)
                self.downloadedImageUrls[key] = image
                completion(image)
            }
        }
    }
}

