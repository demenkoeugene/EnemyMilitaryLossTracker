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
    private var results: [EquipmentLossesOryx] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    var categoriesEquipment = Equipment()
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        configureTableView()
        fetchData()
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
    
    private func fetchData() {
        APIManager.shared.getEquipmentLossesOryx(viewContext: context) { error in
            if let error = error {
                // Handle the error here
                print("Error fetching and saving personnel losses:", error)
            } else {
                self.fetch() // Only one call is needed here
                print("Personnel losses fetched and saved successfully.")
            }
        }
    }
    
    private func fetch() {
        let fetchRequest: NSFetchRequest<EquipmentLossesOryx> = EquipmentLossesOryx.fetchRequest()
        
        do {
            results = try context.fetch(fetchRequest)
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
//               categoriesEquipment.filter(with: searchText)
               tableView.reloadData()
           }
       }
}



extension EquipmentController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesEquipment.allArrays.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        let title = categoriesEquipment.allArrays[indexPath.row].title
        cell.textLabel?.text = title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedEquipmentArray = categoriesEquipment.allArrays[indexPath.row].equipment
        let detailViewController = DetailViewController() // Create an instance
        detailViewController.selectedEquipmentArray = selectedEquipmentArray // Set the property
        navigationController?.pushViewController(detailViewController, animated: true)
    }



}










