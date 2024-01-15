//
//  PopUp.swift
//  Grymm315UI
//
//  Created by Grymm315 on 8/14/18.
//  Copyright © 2018 Grymm315. All rights reserved.
//

import UIKit

class Command {
    public var name:String!
    public var action:() -> Void
    
    init(_ text:String, completionHandler:@escaping () -> Void){
        name = text
        action = completionHandler
    }
}

class PopUp: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView = UITableView()
    public var options:[Command] = []
    public var startFrame:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    
    var tableFrame:CGRect{
        get {
            return CGRect(origin: CGPoint(x: UIScreen.main.bounds.width * 0.2, y: UIScreen.main.bounds.height / 5), size: CGSize(width: (UIScreen.main.bounds.width * 0.6), height: (UIScreen.main.bounds.height / 2)))
        }
    }
    var cancel:UIButton = UIButton()
    var closing:Bool = false
    
    override func viewDidLoad() {
        closing = false
        
        tableView.frame = startFrame
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basic")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 12
        tableView.layer.borderWidth = 0.5
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.backgroundColor = UIColor.black
        //tableView.
        
        cancel.frame = startFrame
        cancel.setTitle("Cancel", for: UIControl.State.normal)
        cancel.setTitleColor(UIColor.white, for: .normal)
        cancel.isEnabled = true
        cancel.backgroundColor = UIColor.black
        cancel.layer.cornerRadius = 12
        cancel.layer.borderWidth = 0.5
        cancel.layer.borderColor = UIColor.lightGray.cgColor
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(refreshControl)
        
        self.view.addSubview(tableView)
        self.view.addSubview(cancel)
        cancel.addTarget(self, action: #selector(self.btn_Cancel(_:)), for: .touchUpInside)
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
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, animations: {
//        UIView.animate(withDuration: 0.6, animations: {
            self.tableView.frame = self.tableFrame
            self.cancel.frame = CGRect(origin: CGPoint(x: self.tableFrame.origin.x, y: self.tableFrame.origin.y + self.tableFrame.height + 4), size: CGSize(width: self.tableFrame.width, height: 44))
            self.view.alpha = 1.0
        })
    }
    
    @objc func btn_Cancel(_ sender: Any?){
        closing = true
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.frame = self.startFrame
            self.cancel.frame = self.startFrame
            self.view.alpha = 0.2
        }, completion: {finish in
            self.removeFromParent()
            self.view.removeFromSuperview()
        })
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
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
        let number = options.count
        
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellThis = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath as IndexPath)
        cellThis.backgroundColor = UIColor.black
        cellThis.textLabel?.textColor = UIColor.white
        cellThis.textLabel?.text = options[indexPath.row].name
        
        return cellThis
    }
    
    func selectedAction(action:Command){
        print("You selected \(action.name ?? "unknown")")
        action.action()
        btn_Cancel(self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        options[indexPath.row].action()
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
}
