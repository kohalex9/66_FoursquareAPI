//
//  ReviewViewController.swift
//  66_FourSquareAPI
//
//  Created by Alex Koh on 06/09/2017.
//  Copyright © 2017 AlexKoh. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    var selectedShopID: String?
    var users: [String] = []
    var reviews: [String] = []
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let id = selectedShopID else {
            return
        }
        loadData(with: id)
    }
    
    func loadData(with category: String) {
        //1. get the url
        //2. get the url session
        //3. create URL task
        //4. start the task
        
        //1.
        let urlString = "https://api.foursquare.com/v2/venues/\(category)/tips?client_id=3BSEEFPD4SQVNEGBIWYVUFJTQEH0BSO35V3AFBY2OVJXMTIH&client_secret=W1DWOM43REOBXDNFLAR13R14FB5N0JPRJF3LH1JFH2KNJWLC&v=20160801&sort=popular&limit=50"
        guard let url = URL(string: urlString) else {return}
        
        //2.
        let session = URLSession.shared
        
        //3.
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {return}
            
            //Convert to json
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let validJson = json as? [String:Any] else {return}
            
            guard let response = validJson["response"] as? [String:Any] else {return}
            guard let tips = response["tips"] as? [String:Any] else {return}
            
            guard let items = tips["items"] as? [[String:Any]] else {return}
            
            for item in items {
                //Extract firstName
                guard let user = item["user"] as? [String:Any] else {
                    print("Fail to get user")
                    return}
                guard let name = user["firstName"] as? String else {
                    print("Fail to get name")
                    return}
                
                //Extract review
                guard let text = item["text"] as? String else {
                    print("Extract text fail")
                    return
                }
                print(name)
                print(text)
                self.users.append(name)
                self.reviews.append(text)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}

extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ReviewTableViewCell else {return UITableViewCell()}
        
        cell.nameLabel.text = users[indexPath.row]
        cell.reviewLabel.text = reviews[indexPath.row]
        
        return cell
    }
}














