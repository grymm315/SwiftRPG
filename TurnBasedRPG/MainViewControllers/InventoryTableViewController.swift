//
//  InventoryTableViewController.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 1/18/20.
//  Copyright © 2020 Chris Phillips. All rights reserved.
//

import UIKit



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
        return GameDatabase.shared.hero.getInventory().count + 2
        } else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "equipmentSlot", for: indexPath) as! NameDescriptionCell
        if (indexPath.row <= GameDatabase.shared.hero.getInventory().count){
            
        }
        else if (indexPath.section == generalSection){
            cell.configCell(item: GameDatabase.shared.hero.getInventory()[indexPath.row])
        } else if (indexPath.section == headSlot){
            cell.configCell(item: GameDatabase.shared.hero.getHead())
        } else if (indexPath.section == armorSlot){
            cell.configCell(item: GameDatabase.shared.hero.getChest())
        } else if (indexPath.section == legSlot){
            cell.configCell(item: GameDatabase.shared.hero.getLegs())
        } else if (indexPath.section == equipedSlot){
            cell.configCell(item: GameDatabase.shared.hero.getWeapon())
        }
        return cell
    }
        
    func getInventorySwipeConfig(indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        print("Swipe detected")
        var actionArray:[UIContextualAction] = []
        if (indexPath.section == generalSection){
            let drop = UIContextualAction(style: .destructive, title: "drop", handler: {_,_,_ in
                GameDatabase.shared.hero.dropItemFromRow(indexPath.row)
                DispatchQueue.main.async { self.tableView.reloadData() }
            })
            let useItem = UIContextualAction(style: .normal, title: "use", handler: {_,_,_ in
                GameDatabase.shared.hero.equipItemFromRow(index: indexPath.row)
                DispatchQueue.main.async { self.tableView.reloadData() }
            })
            actionArray.append(drop)
            actionArray.append(useItem)
        } else if (indexPath.section == headSlot){
            let remove = UIContextualAction(style: .destructive, title: "remove", handler: {_,_,_ in
                GameDatabase.shared.hero.removeHeadPiece()
                DispatchQueue.main.async {self.tableView.reloadData()}
            })
            actionArray.append(remove)
        } else if (indexPath.section == armorSlot){
            let remove = UIContextualAction(style: .destructive, title: "remove", handler: {_,_,_ in
                GameDatabase.shared.hero.removeChestPiece()
                DispatchQueue.main.async {self.tableView.reloadData()}
            })
            actionArray.append(remove)
        } else if (indexPath.section == legSlot){
            let remove = UIContextualAction(style: .destructive, title: "remove", handler: {_,_,_ in
                GameDatabase.shared.hero.removeLegPiece()
                DispatchQueue.main.async {self.tableView.reloadData()}
            })
            actionArray.append(remove)
        } else if (indexPath.section == equipedSlot){
            let remove = UIContextualAction(style: .destructive, title: "remove", handler: {_,_,_ in
                GameDatabase.shared.hero.removeEquipedItem()
                DispatchQueue.main.async {self.tableView.reloadData()}
            })
            actionArray.append(remove)        }
        
        let config = UISwipeActionsConfiguration(actions: actionArray)
        return config
        
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return getInventorySwipeConfig(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return getInventorySwipeConfig(indexPath: indexPath)
    }
    
}
