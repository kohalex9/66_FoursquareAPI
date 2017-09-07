//
//  DetailViewController.swift
//  66_FourSquareAPI
//
//  Created by Alex Koh on 05/09/2017.
//  Copyright © 2017 AlexKoh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedRestaurant: Restaurant?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBAction func showReviewBtnTapped(_ sender: Any) {
        
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as? ReviewViewController else {return}
        
        targetVC.selectedShopID = selectedRestaurant?.shopID
        
        navigationController?.pushViewController(targetVC, animated: true)
    }
    
    @IBAction func showWebPageBtnTapped(_ sender: Any) {
        print(selectedRestaurant?.urlString ?? "No urlString!")
        
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else {return}
        
        targetVC.selectedRestaurant = selectedRestaurant
        
        navigationController?.pushViewController(targetVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        nameLabel.text = "Name: \(selectedRestaurant?.name ?? "Name unavailable")"
        contactLabel.text = "Contact: \(selectedRestaurant?.phone ?? "Contact unavailable")"
        addressLabel.text = "Address: \(selectedRestaurant?.address ?? "Address unavailable")"
        categoryLabel.text = "Category: \(selectedRestaurant?.category ?? "Category unavailable")"
    }
}












