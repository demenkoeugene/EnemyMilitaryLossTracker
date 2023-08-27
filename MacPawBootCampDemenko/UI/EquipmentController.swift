//
//  ViewController.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 21.08.2023.
//
import CoreData
import UIKit

class EquipmentController: UIViewController, UISearchResultsUpdating {
    
    let context = PersistenceController.shared.container.viewContext
    var results: [EquipmentLossesOryxCoreData] = []
    private var searchController = UISearchController(searchResultsController: nil)
    
    var categoriesEquipment = Equipment()
    var searchIsActive = false
    
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        configureTableView()
        fetchData()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    @objc func refreshData() {
        fetchDataAndUpdateUI()
        tableView.refreshControl?.endRefreshing()
    }

    
    private func setupSearchController(){
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation=false
        self.searchController.hidesNavigationBarDuringPresentation=false
        self.searchController.searchBar.placeholder = "search"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableDelegate()
        tableView.rowHeight = 50
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CellIdentifier")
        tableView.pin(to: view)
        tableView.delegate = self
    }
    
    func setTableDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchData() {
        APIManager.shared.getEquipmentLossesOryx(viewContext: context) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching and saving equipment losses:", error)
            } else {
                self.fetchDataAndUpdateUI()
                print("Equipment losses fetched and saved successfully.")
            }
        }
    }
    
    func fetchDataAndUpdateUI() {
        do {
            results = try context.fetch(EquipmentLossesOryxCoreData.fetchRequest())
            categoriesEquipment = Equipment(equipment: results)
            print("Total results count:", results.count)
            tableView.reloadData()
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    
    
}


extension EquipmentController: UITableViewDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased() {
            searchIsActive = !searchText.isEmpty // Update the searchIsActive flag
            
            categoriesEquipment = Equipment(equipment: results)
            categoriesEquipment.filteredArrays = categoriesEquipment.allArrays.filter {
                $0.title.lowercased().contains(searchText)
            }
            
            tableView.reloadData()
        }
    }
}



extension EquipmentController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchIsActive {
            return categoriesEquipment.filteredArrays.count
        } else {
            return categoriesEquipment.allArrays.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        let equipmentArray: [EquipmentLossesOryxCoreData]
        
        if searchIsActive {
            equipmentArray = categoriesEquipment.filteredArrays[indexPath.row].equipment
        } else {
            equipmentArray = categoriesEquipment.allArrays[indexPath.row].equipment
        }
        
        cell.textLabel?.text = equipmentArray.first?.equipmentOryx // Display the first equipment's name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedEquipmentArray: [EquipmentLossesOryxCoreData]
        
        if searchIsActive {
            selectedEquipmentArray = categoriesEquipment.filteredArrays[indexPath.row].equipment
        } else {
            selectedEquipmentArray = categoriesEquipment.allArrays[indexPath.row].equipment
        }
        
        let detailViewController = DetailViewController()
        detailViewController.selectedEquipmentArray = selectedEquipmentArray
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
        
    }
}
