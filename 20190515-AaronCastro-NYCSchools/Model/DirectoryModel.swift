//
//  Parsing.swift
//  20190515-AaronCastro-NYCSchools
//
//  Created by User on 5/14/19.
//  Copyright © 2019 Aaron. All rights reserved.
//

import UIKit
 
struct DirectoryInfo: Codable {
    let dbnDirectory: String
    let borough: String?
    let latitude: String?
    let location: String
    let longitude: String?
    let schoolName: String
    
    enum CodingKeys: String, CodingKey {
        case dbnDirectory = "dbn_dyrectory"
        case borough
        case latitude
        case location
        case longitude
        case schoolName = "school_name"
    }
}
