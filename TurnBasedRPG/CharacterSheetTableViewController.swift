//
//  CharacterSheetTableViewController.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 1/19/20.
//  Copyright © 2020 Chris Phillips. All rights reserved.
//

import UIKit

class CharacterSheetTableViewController: UITableViewController, ReloadProtocol {

    
    let db: GameDatabase = GameDatabase.shared
    lazy var keyring = db.hero.stats.keys.sorted()
    
    func reload() {
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0) {
            return 1} else
            if (section == 1){
                return keyring.count
            } else {
                return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "blurbCell", for: indexPath) as! BlurbCell
            cell.configCell()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as! StatCell
            cell.configCell(type: keyring[indexPath.row])
            cell.tableView = self
            return cell
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }    
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

class BlurbCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var xpBar: UISlider!
    
    func configCell(){
        name.text = GameDatabase.shared.hero.name
        level.text = "Lvl. \(GameDatabase.shared.hero.level)"
        xpBar.value = 0.1
    }
    
}

protocol ReloadProtocol {
    func reload()
}

class StatCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    var tableView: ReloadProtocol?
    
    lazy var stat = GameDatabase.shared.hero.stats[name.text!]
    
    @IBAction func raiseStat(_ sender: Any) {
        GameDatabase.shared.hero.raiseStat(name.text!)
        tableView?.reload()
    }
    @IBAction func lowerStat(_ sender: Any) {
        GameDatabase.shared.hero.lowerStat(name.text!)
        tableView?.reload()
    }
    
    func configCell(type: String){
        name.text = type
        value.text = "\(stat ?? 0)"
    }
}
