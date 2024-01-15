//
//  CharacterSheetTableViewController.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 1/19/20.
//  Copyright © 2020 Chris Phillips. All rights reserved.
//

import UIKit

/// The Character sheet will be the primary view for examing stats

class CharacterSheetTableViewController: UITableViewController, ReloadProtocol {
//    let db: GameDatabase = GameDatabase.shared
    
    // The KeyRing uses a sorted Key Value pair.
    // But more simply "Strength" is the Key, 8 is the value
    // All the values are "sorted" so that it always appears in the same order
    
    // There could certainly be a better solution for this... but this is *good enough*
    lazy var statKeyring = GameDatabase.shared.hero.stats.keys.sorted()
    
    // Defining these variables for readability,
    // Notice they are set to private because other classes don't need to modify this convenience code
    // Changing order of sections is done here as well
    private var headingSection: Int = 0
    private var statSection: Int = 1
    private var traitsSection: Int = 2
    
    // Reload is defined as a method so it can be tied to the storyboard
    // and so we can throw in random extra stuff during a reload or to stop a reload
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        SoundController.shared.speak("Wow. These stats don't look good. Maybe you should do something about that")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == headingSection) {
            //We only need 1 heading
            return 1} else if (section == statSection) {
                // We are showing all the stats in the keyring
                return statKeyring.count
            } else if (section == traitsSection) {
                // Just 1 trait for now as it is mocked up
                return 1
            } else {
                return 0
            }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Look at the storyboard to see what cells are being referenced
        // Each cell type is defined as a class
        
        
        if (indexPath.section == headingSection){
            //This cell configures itself
            let cell = tableView.dequeueReusableCell(withIdentifier: "blurbCell", for: indexPath) as! BlurbCell
            cell.configCell()
            return cell
        } else if (indexPath.section == statSection){
            //This cell is configured by passing in a parameter, in this case the indexPath of the StatKeyRing
            let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as! StatCell
            cell.configCell(type: statKeyring[indexPath.row])
            cell.tableView = self
            return cell
        } else {
            //This cell takes 2 parameters
            let cell = tableView.dequeueReusableCell(withIdentifier: "traitCell", for: indexPath) as! TraitCell
            cell.configCell(title: "Toast", subtitle: "Slightly crunchy and bland as fuck. You need somebody to butter your bread.")
            cell.tableView = self
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension//275.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == headingSection){
            return "General Info"
        } else if (section == statSection){
            return "Stats"
        } else if (section == traitsSection){
            return "Traits"
        } else {
            return ""
        }
    }

}

//Quick reference to the essentials info
class BlurbCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var xpBar: UISlider!
    @IBOutlet weak var ptsAvail: UILabel!
    
    /// The Blurb Cell configures itself by looking at static hero values
    func configCell(){
        name.text = GameDatabase.shared.hero.name
        level.text = "Lvl. \(GameDatabase.shared.hero.level)"
        ptsAvail.text = "\(GameDatabase.shared.hero.getLevelUpsAvailable()) PTS."
        xpBar.value = 0.1
    }
}

/// The reload protocol is a handy way for one class to send info between classes
protocol ReloadProtocol {
    func reload()
}

//Cell view for traits
class TraitCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subtitle1: UILabel!
    
    var tableView: ReloadProtocol?
    
    /// This takes 2 string parameters
    func configCell(title: String, subtitle: String){
        name.text = title
        subtitle1.text = subtitle
    }
    
}

/** Cell view for the Stats on the character sheet
 
 **/
class StatCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    /// Value of the stat for example Strength 8, the value is 8
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var upButton: UIButtonGUI!
    @IBOutlet weak var downButton: UIButtonGUI!
    
    var tableView: ReloadProtocol?
    
    //Grabbing the stat from the Database model by name
    lazy var stat = GameDatabase.shared.hero.stats[name.text!]
    
    //
    @IBAction func raiseStat(_ sender: Any) {
        GameDatabase.shared.hero.raiseStat(name.text!)
        DispatchQueue.main.async {
            self.value.text = "\(self.getStat())"
            self.tableView?.reload()
        }
    }
    @IBAction func lowerStat(_ sender: Any) {
        GameDatabase.shared.hero.lowerStat(name.text!)
        value.text = "\(getStat())"
        tableView?.reload()
    }
    
    func configCell(type: String){
        name.text = type
        value.text = "\(getStat())"
        // Taking away ability to freely allocate points
        upButton.isHidden = false
        downButton.isHidden = true
    }
    
    func getStat() -> UInt8 {
        return GameDatabase.shared.hero.stats[name.text!] ?? 0
    }
}
