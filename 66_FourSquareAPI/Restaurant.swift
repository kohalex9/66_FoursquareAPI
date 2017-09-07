//
//  SushiRestaurant.swift
//  66_FourSquareAPI
//
//  Created by Alex Koh on 05/09/2017.
//  Copyright © 2017 AlexKoh. All rights reserved.
//

import UIKit

class Restaurant {
    var name: String?
    var phone: String?
    var address: String?
    var category: String?
    var urlString: String?
    var shopID: String?
    
    init(name: String, phone: String, address: String, category: String, urlString: String, shopID: String) {
        self.name = name
        self.phone = phone
        self.address = address
        self.category = category
        self.urlString = urlString
        self.shopID = shopID
    }
    
    init() {
        
    }
}
