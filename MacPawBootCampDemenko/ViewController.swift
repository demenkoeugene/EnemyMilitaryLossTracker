//
//  ViewController.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 21.08.2023.
//

import UIKit
import CoreData



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private var personnelLosses: [PersonnelLosses] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchData()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        // Set up constraints for the tableView using Auto Layout
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchData() {
        APIManager.shared.getPersonnelLosses(viewContext: PersistenceController.shared.container.viewContext)
        reloadTableViewData()
    }


    private func reloadTableViewData() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<PersonnelLosses> = PersonnelLosses.fetchRequest()

        do {
            personnelLosses = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personnelLosses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let personnelLoss = personnelLosses[indexPath.row]

        cell.textLabel?.text = personnelLoss.date
        // Configure other cell content based on your data

        return cell
    }
}


