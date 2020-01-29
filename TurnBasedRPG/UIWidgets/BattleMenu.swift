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
    func chose(action:String)
}


//The Battle Menu will
class BattleMenu: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let grandRatio: CGFloat = 0.6180340
    var tableView: UITableView = UITableView()
    public var mData: [String] = []
    public var startFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var tableFrame:CGRect{
        get {
            return CGRect(origin: CGPoint(x: 0, y: UIScreen.main.bounds.height *  grandRatio), size: CGSize(width: (UIScreen.main.bounds.width * (1 - grandRatio)), height: (UIScreen.main.bounds.height * (1.0 - grandRatio))))
        }
    }
    var delegate:BattleMenuDelegate?
    var menuItems = ["Attack", "Magic", "Item", "Escape"]
    
    //    var cancel:UIButton = UIButton()
    var closing:Bool = false
    
    override func viewDidLoad() {
        
        closing = false
        
        tableView.frame = startFrame
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "battle")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 12
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.backgroundColor = UIColor.black
        
        
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
            self.tableView.frame = self.tableFrame
            self.view.alpha = 1.0
        })
    }
    
    @objc func btn_Cancel(_ sender: Any?){
        closing = true
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.frame = self.startFrame
            self.view.alpha = 0.2
        }, completion: {finish in
            self.removeFromParent()
            self.view.removeFromSuperview()
        })
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("Refreshing")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(connectionTimer), userInfo: nil, repeats: false)
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc func connectionTimer() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
        cellThis.backgroundColor = UIColor.black
        cellThis.textLabel?.textColor = UIColor.white
        cellThis.textLabel?.text = menuItems[indexPath.row]
        
        return cellThis
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        stateMachine(command: tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "Unknown")
    }
    
    func stateMachine(command: String){
        
        switch command {
        case "Fight":
            print(command)
        case "Magic":
            print(command)
        case "Item":
            print(command)
        case "Escape":
            print(command)
        default:
            print(command)
        }
        btn_Cancel(self)
        delegate?.chose(action: command)
    }
}
