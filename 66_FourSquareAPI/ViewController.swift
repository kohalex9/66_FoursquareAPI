//
//  ViewController.swift
//  66_FourSquareAPI
//
//  Created by Alex Koh on 05/09/2017.
//  Copyright © 2017 AlexKoh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var restaurants: [Restaurant] = []

    @IBOutlet weak var searchCategoryTextField: UITextField!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(with: "sushi")
    }
    
    func loadData(with category: String) {
        //1. get the url
        //2. get the url session
        //3. create URL task
        //4. start the task
        
        //1.
        let urlString = "https://api.foursquare.com/v2/venues/search?client_id=3BSEEFPD4SQVNEGBIWYVUFJTQEH0BSO35V3AFBY2OVJXMTIH&client_secret=W1DWOM43REOBXDNFLAR13R14FB5N0JPRJF3LH1JFH2KNJWLC&v=20160801&ll=3.1390,101.6869&query=\(category)"
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
            
            guard let venues = validJson["response"] as? [String:Any],
            let fourSquareRestaurants = venues["venues"] as? [[String:Any]] else {return}
            
            for myRestaurant in fourSquareRestaurants {
                
                let restaurant = Restaurant()
                
                //Extract the name
                guard let name = myRestaurant["name"] as? String else {return}
                restaurant.name = name
                
                //Extract contact
                guard let contacts = myRestaurant["contact"] as? [String:String]else {return}
                if let phone = contacts["phone"] {
                    restaurant.phone = phone
                }
                
                //Extract the address
                if let location = myRestaurant["location"] as? [String:Any],
                    let address = location["address"] as? String {
                    restaurant.address = address
                }
                
                //Extract category
                guard let categories = myRestaurant["categories"] as? [[String:Any]] else {return}
                for category in categories {
                    if let categoryName = category["name"] as? String {
                        restaurant.category = categoryName
                    } else {
                        print("Invalid category")
                    }
                }
                
                //Extract url
                if let urlString = myRestaurant["url"] as? String {
                   restaurant.urlString = urlString
                }
                
                //Extract shopID (venuePage)
                if let id = myRestaurant["id"] as? String {
                    restaurant.shopID = id
                }
                
                
                self.restaurants.append(restaurant)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        
        restaurants = []
        if let userCategory = searchCategoryTextField.text {
            loadData(with: userCategory)
        }
        tableView.reloadData()
        
    }
  
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RestaurantTableViewCell else {return UITableViewCell()}
        
        //setup
        cell.restaurantNameLabel.text = restaurants[indexPath.row].name
        cell.addressLabel.text = restaurants[indexPath.row].address
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let target = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        
        target.selectedRestaurant = restaurants[indexPath.row]
        
        navigationController?.pushViewController(target, animated: true)
    }
}

























