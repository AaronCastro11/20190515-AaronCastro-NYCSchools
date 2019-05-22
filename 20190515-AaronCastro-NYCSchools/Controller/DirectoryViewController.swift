//
//  ViewController.swift
//  20190515-AaronCastro-NYCSchools
//
//  Created by User on 5/14/19.
//  Copyright © 2019 Aaron. All rights reserved.
//

import UIKit

class DirectoryViewController: UIViewController {
    
                                            // MARK: - Properties
    
    var directoryArray = [DirectoryInfo]()
    var dbnOfRowAt = ""
    var schoolOfRowAt = ""
    let directoryName = "directory"
    let fileExtension = "json"
    let resultsName = "results"
    var searchController = UISearchController()
    var filteredArray = [DirectoryInfo]()
    var isSearching = false
    
    @IBOutlet weak var directoryTableView: UITableView!
    
                                                // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDictionaryData()
        setupNavBar()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResultsView" {
            let resultsVC = segue.destination as! ResultsViewController
            resultsVC.dbnPassed = dbnOfRowAt
            resultsVC.schooNamePassed = schoolOfRowAt
        }
    }
    
                                            // MARK: - Setup Methods
    
    func setupNavBar() {
        navigationItem.title = "Schools Directory"
        searchController = UISearchController(searchResultsController: nil)
        directoryTableView.tableHeaderView = searchController.searchBar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
                                            // MARK: - Fetch
    
    func getDictionaryData() {
        // I chose not to make a network call here so that this app would be offline capable. If I had had more time, I would have implemented functionality to check if the locally stored JSON was up to date with the API and to sync any changes to my local copy.
        guard let directoryURL = Bundle.main.url(forResource: directoryName, withExtension: fileExtension) else { return }
        let directoryData = try! Data(contentsOf: directoryURL)
        let directory = try! JSONDecoder().decode([DirectoryInfo].self, from: directoryData)
        directoryArray = directory
        directoryArray.sort { $0.schoolName < $1.schoolName }
        DispatchQueue.main.async {
            self.directoryTableView.reloadData()
        }
    }
}


                            // MARK: - TableView Delegate Methods

extension DirectoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching == false {
            return directoryArray.count
        } else {
            return filteredArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "directoryCell") as! DirectoryCell
        if isSearching == false {
            cell.schoolNameLbl.text = directoryArray[indexPath.row].schoolName
            cell.schoolAdressLbl.text = directoryArray[indexPath.row].location
        } else {
            cell.schoolNameLbl.text = filteredArray[indexPath.row].schoolName
            cell.schoolAdressLbl.text = filteredArray[indexPath.row].location
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching == false {
            dbnOfRowAt = directoryArray[indexPath.row].dbnDirectory
            schoolOfRowAt = directoryArray[indexPath.row].schoolName
            performSegue(withIdentifier: "goToResultsView", sender: self)
        } else {
            dbnOfRowAt = filteredArray[indexPath.row].dbnDirectory
            schoolOfRowAt = filteredArray[indexPath.row].schoolName
            performSegue(withIdentifier: "goToResultsView", sender: self)
        }
    }
    
}

                                        // MARK: - SearchBar Delegate Methods
extension DirectoryViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        directoryTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        directoryTableView.reloadData()
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        var filteredTemp = [DirectoryInfo]()
        filteredTemp = directoryArray.filter({ $0.schoolName.contains(searchBar.text!) })
        filteredArray = filteredTemp
        directoryTableView.reloadData()
    }
}
