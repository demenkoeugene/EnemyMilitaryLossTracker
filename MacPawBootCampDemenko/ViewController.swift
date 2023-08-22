//
//  ViewController.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 21.08.2023.
//
import CoreData
import UIKit

class ViewController: UIViewController {
    let context = PersistenceController.shared.container.viewContext
    var results: [PersonnelLosses] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.title = "Personal Losses"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        configureTableView()
        fetchData()
    }

    
    func configureTableView() {
        view.addSubview(tableView)
        setTableDelegate()
        tableView.rowHeight = 50
        tableView.register(CustomCell.self, forCellReuseIdentifier: "Personal Lossess")
        tableView.pin(to: view)
        tableView.delegate = self
    }
    
    func setTableDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchData() {
        APIManager.shared.getPersonnelLosses(viewContext: context) { error in
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
        let fetchRequest: NSFetchRequest<PersonnelLosses> = PersonnelLosses.fetchRequest()
        do {
            results = try context.fetch(fetchRequest)
            tableView.reloadData() // Reload table view with fetched data
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = results[indexPath.row]
        
        let detailViewController = DetailViewController() // Initialize DetailViewController
        detailViewController.selectedResult = selectedResult // Pass data
        
        print("navigationController:", navigationController) // Print the navigation controller
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Personal Lossess", for: indexPath) as! CustomCell
        let result = results[indexPath.row]
        cell.labelData.text = result.date ?? "No Date" // Use the actual property name
        return cell
    }
}








