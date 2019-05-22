//
//  ResultsViewController.swift
//  20190515-AaronCastro-NYCSchools
//
//  Created by User on 5/14/19.
//  Copyright © 2019 Aaron. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

                                            // MARK: - Properties
    
    var dbnPassed = ""
    var schooNamePassed = ""
    var resultsArray = [ResultsInfo]()
    let fileExtension = "json"
    let resultsName = "results"
    
    @IBOutlet weak var schoolNameLbl: UILabel!
    @IBOutlet weak var SATTestTakersLbl: UILabel!
    @IBOutlet weak var criticalReadingAvgScoreLbl: UILabel!
    @IBOutlet weak var mathAvgScoreLbl: UILabel!
    @IBOutlet weak var writingAvgScoreLbl: UILabel!
    
                                                // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getResultsData(dbnPassed: dbnPassed)
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
                                                // MARK: - Fetch
    
    func getResultsData(dbnPassed: String) {
        guard let resultsURL = Bundle.main.url(forResource: resultsName, withExtension: fileExtension) else { return }

        let resultsData = try! Data(contentsOf: resultsURL)
        
        let results = try! JSONDecoder().decode([ResultsInfo].self, from: resultsData)
        resultsArray = results
        
        for items in resultsArray {
            if items.dbn == dbnPassed {
                schoolNameLbl.text = "School: \(schooNamePassed)"
                SATTestTakersLbl.text = "SAT Test Takers: \(items.numOfSatTestTakers)"
                criticalReadingAvgScoreLbl.text = "SAT Critical Reading Avg Score: \(items.satCriticalReadingAvgScore)"
                mathAvgScoreLbl.text = "SAT Math Avg Score: \(items.satMathAvgScore)"
                writingAvgScoreLbl.text = "SAT Writing Avg Score: \(items.satWritingAvgScore)"
            }
        }
    }
}
