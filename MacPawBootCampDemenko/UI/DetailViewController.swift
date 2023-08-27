//
//  DetailViewController.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 22.08.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var selectedEquipmentArray: [EquipmentLossesOryxCoreData]? = {
        if let equipmentArray = self.selectedEquipmentArray {
            let uniqueEquipmentSet = Set(equipmentArray)
            return Array(uniqueEquipmentSet)
        }
        return nil
    }()
    
    var tableView: UITableView!
    var ascendingOrder = true // Tracks the current sorting order
    
    
    // Labels to display the data
    let dayLabel = UILabel()
    let personnelLabel = UILabel()
    let powLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedEquipmentArray?.first?.equipmentOryx
        navigationItem.largeTitleDisplayMode = .never
        
        // Create a single filter button
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(toggleSorting))
        navigationItem.rightBarButtonItem = filterButton
        
        setupUI()
    }
    
    
    @objc private func toggleSorting() {
        ascendingOrder.toggle()
        updateSortingButtonImage()
        sortSelectedEquipmentArray()
        tableView.reloadData()
    }
    
    private func updateSortingButtonImage() {
        let imageName = ascendingOrder ? "line.3.horizontal.decrease.circle" : "line.3.horizontal.decrease.circle.fill"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    }
    
    private func sortSelectedEquipmentArray() {
        selectedEquipmentArray?.sort { ascendingOrder ? $0.lossesTotal < $1.lossesTotal : $0.lossesTotal > $1.lossesTotal }
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    private func setupUI() {
        tableView = UITableView(frame: view.bounds) // Use the instance variable tableView
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        view.addSubview(tableView)
        tableView.reloadData() // Reload the table view to display the data
    }
    
    
    
    
    
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedEquipmentArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        if let equipment = selectedEquipmentArray?[indexPath.row] {
            let equipmentInfo = """
                Model: \(equipment.model ?? "N/A")
                Manufacturer: \(equipment.manufacturer ?? "N/A")
                Losses Total: \(equipment.lossesTotal)
                """
            
            
            let attributedString = NSMutableAttributedString(string: equipmentInfo)
            
            // Apply bold font to certain parts of the text
            let boldAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: cell.textLabel?.font.pointSize ?? UIFont.systemFontSize)
            ]
            
            attributedString.addAttributes(boldAttributes, range: (equipmentInfo as NSString).range(of: "Model:"))
            attributedString.addAttributes(boldAttributes, range: (equipmentInfo as NSString).range(of: "Manufacturer:"))
            attributedString.addAttributes(boldAttributes, range: (equipmentInfo as NSString).range(of: "Losses Total:"))
            
            cell.textLabel?.numberOfLines = 0 // Allow multiple lines of text
            cell.textLabel?.attributedText = attributedString
        }
        
        
        return cell
    }
}


