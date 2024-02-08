//
//  CharacterSheetTableViewController.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 1/19/20.
//  Copyright © 2020 Chris Phillips. All rights reserved.
//

import UIKit

/// The Character sheet will be the primary view for examing stats, looking at your inventory, or checking quests

class CharacterSheetTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ReloadProtocol {
   
    @IBOutlet weak var heroView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var classLevel: UILabel!
    @IBOutlet weak var healthIndicator: UILabel!
    @IBOutlet weak var manaIndicator: UILabel!
    @IBOutlet weak var xpBar: UIProgressView!
    @IBOutlet weak var energyIndicator: UILabel!
    @IBOutlet weak var listPicker: UISegmentedControl!
    
    @IBOutlet weak var perkPoints: UILabel!
    @IBOutlet weak var battleStats: UILabel!
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var statusEffects: UILabel!
    //    let db: GameDatabase = GameDatabase.shared
    
    // The KeyRing uses a sorted Key Value pair.
    // But more simply "Strength" is the Key, 8 is the value
    // All the values are "sorted" so that it always appears in the same order
    
    // There could certainly be a better solution for this... but this is *good enough*
    lazy var statKeyring = GameDatabase.shared.hero.stats.keys.sorted()
    lazy var questKeyring = GameDatabase.shared.quests.keys.sorted()
    
    // Defining these variables for readability,
    // Notice they are set to private because other classes don't need to modify this convenience code
    // Changing order of sections is done here as well
    private let statsSectionTitles:[String] = ["Stats", "Traits"]
    private var headingSection: Int = 20
    private let statSection: Int = 0
    private let traitsSection: Int = 1
    
    private let statsList: Int = 0
    private let inventoryList: Int = 1
    private let questList: Int = 2
    
    private let inventorySectionTitles:[String] = ["Equipped", "Head", "Armor", "Legs", "General"]
    private let equipedSlot: Int = 0
    private let headSlot: Int = 1
    private let armorSlot: Int = 2
    private let legSlot:Int = 3
    private let generalSection:Int = 4
    
    
    
    // Reload is defined as a method so it can be tied to the storyboard
    // and so we can throw in random extra stuff during a reload or to stop a reload
    func reload() {
        DispatchQueue.main.async {
            self.setHeroView()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeroView()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        heroView.frame = UIScreen.main.goldenSmallTopFrame()
        listView.frame = UIScreen.main.goldenLargeLowerFrame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("TableView: \(tableView.frame) VS ListView: \(listView.frame) VS TopView: \(heroView.frame) OnScreen: \(UIScreen.main.bounds)")
        
        tableView.reloadData()
        SoundController.shared.speak("Wow. These stats don't look good. Maybe you should do something about that")
    }
    
    @IBAction func listChanged(_ sender: Any) {
        reload()
    }
    
    func setHeroView() {
        heroName.text = GameDatabase.shared.hero.name
        classLevel.text = "Lv.\(GameDatabase.shared.hero.getLevel()) \(GameDatabase.shared.hero.profession.description)"
        xpBar.setProgress(Float(GameDatabase.shared.hero.getExperience()) / Float(GameDatabase.shared.hero.getXpToLvl()), animated: true)
        healthIndicator.text = "HP: \(GameDatabase.shared.hero.currentHealth) / \(GameDatabase.shared.hero.maxHealth)"
         manaIndicator.text = "MP: \(GameDatabase.shared.hero.currentMana) / \(GameDatabase.shared.hero.maxMana)"
        energyIndicator.text = "EP: \(GameDatabase.shared.hero.currentEnergy) / \(GameDatabase.shared.hero.maxEnergy)"
        perkPoints.text = "Perk Points: \(GameDatabase.shared.hero.getLevelUpsAvailable())"
        goldLabel.text = "GP: \(GameDatabase.shared.hero.getGold())"
        battleStats.text = "Atk: \(GameDatabase.shared.hero.getAttack()) Def:\(GameDatabase.shared.hero.getDefense())"
        statusEffects.text = "Status Effects: \(GameDatabase.shared.hero.getStatusEffects())"
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (listPicker.selectedSegmentIndex == statsList){
            return 2
        } else if (listPicker.selectedSegmentIndex == inventoryList) {
                return 5
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (listPicker.selectedSegmentIndex == statsList){
            if (section == headingSection) {
                //We only need 1 heading
                return 1
            } else if (section == statSection) {
                    // We are showing all the stats in the keyring
                    return statKeyring.count
            } else if (section == traitsSection) {
                    // Just 1 trait for now as it is mocked up
                    return 1
            } else {
                    return 0
            }
        } else if (listPicker.selectedSegmentIndex == inventoryList){
            if (section == generalSection){
            return GameDatabase.shared.hero.getInventory().count
            } else {
                return 1
            }
        }else if (listPicker.selectedSegmentIndex == questList){
            return GameDatabase.shared.quests.count
        } else {
            return 1
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Look at the storyboard to see what cells are being referenced
        // Each cell type is defined as a class
        if (listPicker.selectedSegmentIndex == statsList){
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
            } else if (indexPath.section == traitsSection){
                //This cell takes 2 parameters
                let cell = tableView.dequeueReusableCell(withIdentifier: "traitCell", for: indexPath) as! TraitCell
                cell.configCell(title: "Toast", subtitle: "Slightly crunchy and bland as fuck. You need somebody to butter your bread.")
                cell.tableView = self
                return cell
            }
        } else if (listPicker.selectedSegmentIndex == inventoryList){
            let cell = tableView.dequeueReusableCell(withIdentifier: "equipmentSlot", for: indexPath) as! NameDescriptionCell
            if (indexPath.section == generalSection && indexPath.row < GameDatabase.shared.hero.getInventory().count){
                cell.configCell(item: GameDatabase.shared.hero.getInventory()[indexPath.row])
            } else if (indexPath.section == headSlot){
                cell.configCell(item: GameDatabase.shared.hero.getHead())
            } else if (indexPath.section == armorSlot){
                cell.configCell(item: GameDatabase.shared.hero.getChest())
            } else if (indexPath.section == legSlot){
                cell.configCell(item: GameDatabase.shared.hero.getLegs())
            } else if (indexPath.section == equipedSlot){
                cell.configCell(item: GameDatabase.shared.hero.getWeapo())
            }
            return cell
        } else if (listPicker.selectedSegmentIndex == questList){
            let cell = tableView.dequeueReusableCell(withIdentifier: "equipmentSlot", for: indexPath) as! NameDescriptionCell
            cell.configQuest(questName: questKeyring[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 18
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        if (listPicker.selectedSegmentIndex == statsList && (section == traitsSection)){
         return 100
        } else if (listPicker.selectedSegmentIndex == inventoryList && (section == generalSection)) {
            return 100
        }
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (listPicker.selectedSegmentIndex == statsList && (section == traitsSection)){
         return 100
        } else if (listPicker.selectedSegmentIndex == inventoryList && (section == generalSection)) {
            return 100
        }
        return 8
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension//275.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (listPicker.selectedSegmentIndex == statsList){
            return statsSectionTitles[section]
        } else if (listPicker.selectedSegmentIndex == inventoryList) {
            return inventorySectionTitles[section]
        } else {
            return "Active"
        }
    }
    
    func getInventorySwipeConfig(indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        print("Swipe detected")
        var actionArray:[UIContextualAction] = []
        if (indexPath.section == generalSection){
            let drop = UIContextualAction(style: .destructive, title: "drop", handler: {_,_,_ in
                GameDatabase.shared.hero.dropItemFromRow(indexPath.row)
                DispatchQueue.main.async { self.reload() }
            })
            let useItem = UIContextualAction(style: .normal, title: "use", handler: {_,_,_ in
                GameDatabase.shared.hero.equipItemFromRow(index: indexPath.row)
                DispatchQueue.main.async { self.reload() }
            })
            actionArray.append(drop)
            actionArray.append(useItem)
        } else if (indexPath.section == headSlot){
            let remove = UIContextualAction(style: .destructive, title: "remove", handler: {_,_,_ in
                GameDatabase.shared.hero.removeHeadPiece()
                DispatchQueue.main.async {self.reload()}
            })
            actionArray.append(remove)
        } else if (indexPath.section == armorSlot){
            let remove = UIContextualAction(style: .destructive, title: "remove", handler: {_,_,_ in
                GameDatabase.shared.hero.removeChestPiece()
                DispatchQueue.main.async {self.reload()}
            })
            actionArray.append(remove)
        } else if (indexPath.section == legSlot){
            let remove = UIContextualAction(style: .destructive, title: "remove", handler: {_,_,_ in
                GameDatabase.shared.hero.removeLegPiece()
                DispatchQueue.main.async {self.reload()}
            })
            actionArray.append(remove)
        } else if (indexPath.section == equipedSlot){
            let remove = UIContextualAction(style: .destructive, title: "remove", handler: {_,_,_ in
                GameDatabase.shared.hero.removeEquipedItem()
                DispatchQueue.main.async {self.reload()}
            })
            actionArray.append(remove)
        }
        let config = UISwipeActionsConfiguration(actions: actionArray)
        return config
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if (listPicker.selectedSegmentIndex == inventoryList){
            return getInventorySwipeConfig(indexPath: indexPath)
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if (listPicker.selectedSegmentIndex == inventoryList){
            return getInventorySwipeConfig(indexPath: indexPath)
        } else {
            return nil
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
        level.text = "Lvl. \(GameDatabase.shared.hero.getLevel())"
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

class NameDescriptionCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    func configCell(item: Equipment?) {
        name.text = item?.name ?? "* empty *"
        desc.text = item?.description ?? ""
        desc.sizeToFit()
    }
    
    func configQuest(questName:String){
        print("Quest: \(questName)")
        name.text = "\(questName)"
        desc.text = GameDatabase.shared.quests[questName] ?? "Unknown"
        self.backgroundColor = UIColor.black
        desc.sizeToFit()
    }
    
    func getDetails() -> String {
        return GameDatabase.shared.quests[name.text!] ?? "Unknown"
    }
}
