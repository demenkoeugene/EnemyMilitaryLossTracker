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
        print("hello")
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



struct Equipment {
    var antiAircraftGuns: [EquipmentLossesOryx] = []
    var jammersAndDeceptionSystems: [EquipmentLossesOryx] = []
    var commandPostsAndCommunicationsStations: [EquipmentLossesOryx] = []
    var multipleRocketLaunchers: [EquipmentLossesOryx] = []
    var surfaceToAirMissileSystems: [EquipmentLossesOryx] = []
    var trucksVehiclesAndJeeps: [EquipmentLossesOryx] = []
    var armouredFightingVehicles: [EquipmentLossesOryx] = []
    var selfPropelledAntiTankMissileSystems: [EquipmentLossesOryx] = []
    var mineResistantAmbushProtected: [EquipmentLossesOryx] = []
    var aircraft: [EquipmentLossesOryx] = []
    var selfPropelledAntiAircraftGuns: [EquipmentLossesOryx] = []
    var infantryMobilityVehicles: [EquipmentLossesOryx] = []
    var selfPropelledArtillery: [EquipmentLossesOryx] = []
    var towedArtillery: [EquipmentLossesOryx] = []
    var tanks: [EquipmentLossesOryx] = []
    var artillerySupportVehiclesAndEquipment: [EquipmentLossesOryx] = []
    var helicopters: [EquipmentLossesOryx] = []
    var navalShips: [EquipmentLossesOryx] = []
    var radars: [EquipmentLossesOryx] = []
    var reconnaissanceUnmannedAerialVehicles: [EquipmentLossesOryx] = []
    var infantryFightingVehicles: [EquipmentLossesOryx] = []
    var unmannedCombatAerialVehicles: [EquipmentLossesOryx] = []
    var engineeringVehiclesAndEquipment: [EquipmentLossesOryx] = []
    var armouredPersonnelCarriers: [EquipmentLossesOryx] = []
    
    init(equipment: [EquipmentLossesOryx]) {
        self.antiAircraftGuns = filterEquipment(equipment, categoryName: "Anti-Aircraft Guns")
        self.jammersAndDeceptionSystems = filterEquipment(equipment, categoryName: "Jammers And Deception Systems")
        self.commandPostsAndCommunicationsStations = filterEquipment(equipment, categoryName: "Command Posts And Communications Stations")
        self.multipleRocketLaunchers = filterEquipment(equipment, categoryName: "Multiple Rocket Launchers")
        self.surfaceToAirMissileSystems = filterEquipment(equipment, categoryName: "Surface-To-Air Missile Systems")
        self.trucksVehiclesAndJeeps = filterEquipment(equipment, categoryName: "Trucks, Vehicles and Jeeps")
        self.armouredFightingVehicles = filterEquipment(equipment, categoryName: "Armoured Fighting Vehicles")
        self.selfPropelledAntiTankMissileSystems = filterEquipment(equipment, categoryName: "Self-Propelled Anti-Tank Missile Systems")
        self.mineResistantAmbushProtected = filterEquipment(equipment, categoryName: "Mine-Resistant Ambush Protected")
        self.aircraft = filterEquipment(equipment, categoryName: "Aircraft")
        self.selfPropelledAntiAircraftGuns = filterEquipment(equipment, categoryName: "Self-Propelled Anti-Aircraft Guns")
        self.infantryMobilityVehicles = filterEquipment(equipment, categoryName: "Infantry Mobility Vehicles")
        self.selfPropelledArtillery = filterEquipment(equipment, categoryName: "Self-Propelled Artillery")
        self.towedArtillery = filterEquipment(equipment, categoryName: "Towed Artillery")
        self.tanks = filterEquipment(equipment, categoryName: "Tanks")
        self.artillerySupportVehiclesAndEquipment = filterEquipment(equipment, categoryName: "Artillery Support Vehicles And Equipment")
        self.helicopters = filterEquipment(equipment, categoryName: "Helicopters")
        self.navalShips = filterEquipment(equipment, categoryName: "Naval Ships")
        self.radars = filterEquipment(equipment, categoryName: "Radars")
        self.reconnaissanceUnmannedAerialVehicles = filterEquipment(equipment, categoryName: "Reconnaissance Unmanned Aerial Vehicles")
        self.infantryFightingVehicles = filterEquipment(equipment, categoryName: "Infantry Fighting Vehicles")
        self.unmannedCombatAerialVehicles = filterEquipment(equipment, categoryName: "Unmanned Combat Aerial Vehicles")
        self.engineeringVehiclesAndEquipment = filterEquipment(equipment, categoryName: "Engineering Vehicles And Equipment")
        self.armouredPersonnelCarriers = filterEquipment(equipment, categoryName: "Armoured Personnel Carriers")
    }
    init(){
    }
    
    // Private function for filtering equipment based on category name
    private func filterEquipment(_ equipment: [EquipmentLossesOryx], categoryName: String) -> [EquipmentLossesOryx] {
        return equipment.filter { $0.equipmentOryx == categoryName }
    }
}

extension Equipment {
    var allArrays: [(title: String, equipment: [EquipmentLossesOryx])] {
        [
            ("Anti-Aircraft Guns", antiAircraftGuns),
            ("Jammers And Deception Systems", jammersAndDeceptionSystems),
            ("Command Posts And Communications Stations", commandPostsAndCommunicationsStations),
            ("Multiple Rocket Launchers", multipleRocketLaunchers),
            ("Surface-To-Air Missile Systems", surfaceToAirMissileSystems),
            ("Trucks, Vehicles and Jeeps", trucksVehiclesAndJeeps),
            ("Armoured Fighting Vehicles", armouredFightingVehicles),
            ("Self-Propelled Anti-Tank Missile Systems", selfPropelledAntiTankMissileSystems),
            ("Mine-Resistant Ambush Protected", mineResistantAmbushProtected),
            ("Aircraft", aircraft),
            ("Self-Propelled Anti-Aircraft Guns", selfPropelledAntiAircraftGuns),
            ("Infantry Mobility Vehicles", infantryMobilityVehicles),
            ("Self-Propelled Artillery", selfPropelledArtillery),
            ("Towed Artillery", towedArtillery),
            ("Tanks", tanks),
            ("Artillery Support Vehicles And Equipment", artillerySupportVehiclesAndEquipment),
            ("Helicopters", helicopters),
            ("Naval Ships", navalShips),
            ("Radars", radars),
            ("Reconnaissance Unmanned Aerial Vehicles", reconnaissanceUnmannedAerialVehicles),
            ("Infantry Fighting Vehicles", infantryFightingVehicles),
            ("Unmanned Combat Aerial Vehicles", unmannedCombatAerialVehicles),
            ("Engineering Vehicles And Equipment", engineeringVehiclesAndEquipment),
            ("Armoured Personnel Carriers", armouredPersonnelCarriers)
        ]
    }
}







