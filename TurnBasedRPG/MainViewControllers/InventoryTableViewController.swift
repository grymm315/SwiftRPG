//
//  InventoryTableViewController.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 1/18/20.
//  Copyright © 2020 Chris Phillips. All rights reserved.
//

import UIKit

class InventoryCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    func configCell(item: Equipment) {
        name.text = item.name ?? "--"
        desc.text = item.description ?? "--"
    }
}

class InventoryTableViewController: UITableViewController, ReloadProtocol {
    
    

    var equipedSlot: Int = 0
    var headSlot: Int = 1
    var armorSlot: Int = 2
    var legSlot:Int = 3
    var generalSection:Int = 4
    
    var sectionTitles:[String] = ["Equipped", "Head", "Armor", "Legs", "General"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == generalSection){
        return GameDatabase.shared.hero.getInventory().count
        } else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "equipmentSlot", for: indexPath) as! InventoryCell
        if (indexPath.section == generalSection){
            cell.configCell(item: GameDatabase.shared.hero.getInventory()[indexPath.row])
        } else if (indexPath.section == headSlot){
            cell.configCell(item: GameDatabase.shared.hero.getHead() ?? Armor(name: "empty", description: ""))
        } else if (indexPath.section == armorSlot){
            cell.configCell(item: GameDatabase.shared.hero.getChest() ?? Armor(name: "empty", description: ""))
        } else if (indexPath.section == legSlot){
            cell.configCell(item: GameDatabase.shared.hero.getLegs() ?? Armor(name: "your junk is swinging in the breeze", description: ""))
        } else if (indexPath.section == equipedSlot){
            cell.configCell(item: GameDatabase.shared.hero.getWeapo() ?? Weapon(name: "empty", description: ""))
        }
        return cell
    }
        
    func getSwipeConfig(indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        print("Swipe detected")
        var actionArray:[UIContextualAction] = []
        if (indexPath.section == generalSection){
            let drop = UIContextualAction(style: .destructive, title: "drop", handler: {_,_,_ in
              
                GameDatabase.shared.hero.dropItemFromRow(indexPath.row)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            actionArray.append(drop)
            
        } else if (indexPath.section == headSlot){
//            GameDatabase.shared.hero.headEquipmentSlot
        } else if (indexPath.section == armorSlot){
//             GameDatabase.shared.hero.chestEquipmentSlot
        } else if (indexPath.section == legSlot){
//            GameDatabase.shared.hero.legsEquipmentSlot
        } else if (indexPath.section == equipedSlot){
//            GameDatabase.shared.hero.equippedSlot
        }
        
        let config = UISwipeActionsConfiguration(actions: actionArray)
        return config
        
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return getSwipeConfig(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return getSwipeConfig(indexPath: indexPath)
    }
    
}
