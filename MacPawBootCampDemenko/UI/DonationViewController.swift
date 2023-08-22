//
//  DonationViewController.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 22.08.2023.
//
import UIKit

class DonationViewController: UIViewController {
    
    var results: [DonationModel] = []
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureTableView()
        fetchData()
    }

    func configureTableView() {
        view.addSubview(tableView)
        setTableDelegate()
        tableView.rowHeight = 50
        tableView.register(CustomCell.self, forCellReuseIdentifier: "DonationCell")
        tableView.pin(to: view)
    }
    
    func setTableDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchData() {
        APIManager.shared.parseDonationJSON { [weak self] result in
            switch result {
            case .success(let donations):
                self?.results = donations
                self?.tableView.reloadData()
            case .failure(let error):
                print("Error fetching donation data:", error)
            }
        }
    }
}

extension DonationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonationCell", for: indexPath) as! CustomCell
        let donation = results[indexPath.row]
        cell.labelData.text = donation.name
        return cell
    }
}

extension DonationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let donation = results[indexPath.row]
        if let url = URL(string: donation.organisationURL) {
            UIApplication.shared.open(url)
        }
    }
}

