//
//  BattleMenu.swift
//  TurnBasedRPG
//
//  Created by TACTILIS on 8/18/19.
//  Copyright © 2019 Chris Phillips. All rights reserved.
//

import UIKit

protocol BattleMenuDelegate {
    func chose(action:String)
}

class BattleMenu: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let GR:CGFloat = 0.6180340
    var tableView:UITableView = UITableView()
    public var mData:[String] = []
    public var startFrame:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var tableFrame:CGRect{
        get {
            return CGRect(origin: CGPoint(x: 0, y: UIScreen.main.bounds.height *  GR), size: CGSize(width: (UIScreen.main.bounds.width * (1 - GR)), height: (UIScreen.main.bounds.height * (1.0 - GR))))
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
        //tableView.
        
//        cancel.frame = startFrame
//        cancel.setTitle("Cancel", for: UIControl.State.normal)
//        cancel.setTitleColor(UIColor.white, for: .normal)
//        cancel.isEnabled = true
//        cancel.backgroundColor = UIColor.black
//        cancel.layer.cornerRadius = 12
//        cancel.layer.borderWidth = 0.5
//        cancel.layer.borderColor = UIColor.lightGray.cgColor
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(refreshControl)
        
        self.view.addSubview(tableView)
//        self.view.addSubview(cancel)
//        cancel.addTarget(self, action: #selector(self.btn_Cancel(_:)), for: .touchUpInside)
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
//            self.cancel.frame = CGRect(origin: CGPoint(x: self.tableFrame.origin.x, y: self.tableFrame.origin.y + self.tableFrame.height + 4), size: CGSize(width: self.tableFrame.width, height: 44))
            self.view.alpha = 1.0
        })
    }
    
    @objc func btn_Cancel(_ sender: Any?){
        closing = true
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.frame = self.startFrame
//            self.cancel.frame = self.startFrame
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
        //let number = mData.count
        
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellThis = tableView.dequeueReusableCell(withIdentifier: "battle", for: indexPath as IndexPath)
        cellThis.backgroundColor = UIColor.black
        cellThis.textLabel?.textColor = UIColor.white
        //cellThis.textLabel?.font.withSize(22)
        cellThis.textLabel?.text = menuItems[indexPath.row]
        
        return cellThis
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        stateMachine(command: tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "Unknown")
//        self.removeFromParent()
//        self.view.removeFromSuperview()
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
