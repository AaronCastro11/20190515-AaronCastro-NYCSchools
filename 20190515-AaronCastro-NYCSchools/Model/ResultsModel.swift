//
//  ResultsModel.swift
//  20190515-AaronCastro-NYCSchools
//
//  Created by User on 5/14/19.
//  Copyright © 2019 Aaron. All rights reserved.
//

import Foundation

struct ResultsInfo: Codable {
    let dbn: String
    let numOfSatTestTakers: String
    let satCriticalReadingAvgScore: String
    let satMathAvgScore: String
    let satWritingAvgScore: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
    
}


