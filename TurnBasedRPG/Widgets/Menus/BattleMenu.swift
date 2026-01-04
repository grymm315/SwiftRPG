//
//  BattleMenu.swift
//  TurnBasedRPG
//
//  Created by Grymm315 on 8/18/19.
//  Copyright © 2019 Chris Phillips. All rights reserved.
//

import UIKit
import AVFoundation

protocol BattleMenuDelegate {
    func chose(action:ActiveSkill)
}


//The Battle Menu will show up
class BattleMenu: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let grandRatio: CGFloat = 0.6180340
    var tableView: UITableView = UITableView()
    public var mData: [String] = []
    
    var leftStartFrame: CGRect = CGRect(x: 0, y: UIScreen.main.bounds.height, width: 0, height: 0)
    var rightStartFrame: CGRect = CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height, width: 0, height: 0)

    
    var leftHandedTableFrame:CGRect{
        get {
            return CGRect(origin: CGPoint(x: 0, y: UIScreen.main.bounds.height *  grandRatio), size: CGSize(width: (UIScreen.main.bounds.width * (1 - grandRatio)), height: (UIScreen.main.bounds.height * (1.0 - grandRatio))))
        }
    }
    
    var rightHandedTableFrame:CGRect{
        get {
            return CGRect(origin: CGPoint(x: UIScreen.main.bounds.width - UIScreen.main.bounds.width * (1 - grandRatio), y: UIScreen.main.bounds.height *  grandRatio), size: CGSize(width: (UIScreen.main.bounds.width * (1 - grandRatio)), height: (UIScreen.main.bounds.height * (1.0 - grandRatio))))
        }
    }
    var delegate:BattleMenuDelegate?
    var menuItems:[ActiveSkill] = [Fireball(), Punch()]
    
    //    var cancel:UIButton = UIButton()
    var closing:Bool = false
    
    override func viewDidLoad() {
        
        closing = false
        
        tableView.frame = rightStartFrame
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "battle")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 12
        tableView.layer.borderWidth = 8
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.backgroundColor = UIColor.blue
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
        self.view.addSubview(tableView)
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(connectionTimer), userInfo: nil, repeats: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        closing = false
        self.view.alpha = 0.2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.frame = self.rightHandedTableFrame
            self.view.alpha = 1.0
        })
    }
    
//    func stateMachine(command: String){
//        
//        switch command {
//        case "Fight":
//            print(command)
//        case "Magic":
//            print(command)
//        case "Item":
//            print(command)
//        case "Escape":
//            print(command)
//        default:
//            print(command)
//        }
//        btn_Cancel(self)
//        delegate?.chose(action: command)
//    }
    
    @objc func btn_Cancel(_ sender: Any?){
        closing = true
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.frame = self.rightStartFrame
            self.view.alpha = 0.2
        }, completion: {finish in
            self.removeFromParent()
            self.view.removeFromSuperview()
        })
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("Refreshing")
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(connectionTimer), userInfo: nil, repeats: false)
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc func connectionTimer() {
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellThis = tableView.dequeueReusableCell(withIdentifier: "battle", for: indexPath as IndexPath)
        cellThis.backgroundColor = UIColor.blue
        cellThis.textLabel?.textColor = UIColor.white
        cellThis.textLabel?.font = UIFont(name: "Courier New Bold", size: 14)
        cellThis.textLabel?.shadowColor = UIColor.black
        cellThis.textLabel?.shadowOffset = CGSize(width: 1, height: 1)
        cellThis.textLabel?.text = menuItems[indexPath.row].name
        
        return cellThis
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        stateMachine(command: tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "Unknown")
        delegate?.chose(action: menuItems[indexPath.row])
        btn_Cancel(self)
    }
    
    
}
