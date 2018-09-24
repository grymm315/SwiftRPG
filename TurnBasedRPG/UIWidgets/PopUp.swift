//
//  PopUp.swift
//  TactilisUI
//
//  Created by TACTILIS on 8/14/18.
//  Copyright © 2018 TACTILIS. All rights reserved.
//

import UIKit

class PopUp: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView = UITableView()
    public var mData:[String] = []
    public var startFrame:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var tableFrame:CGRect{
        get {
            return CGRect(origin: CGPoint(x: UIScreen.main.bounds.width * 0.2, y: UIScreen.main.bounds.height / 5), size: CGSize(width: (UIScreen.main.bounds.width * 0.6), height: (UIScreen.main.bounds.height / 2)))
        }
    }
     var cancel:UIButton = UIButton()
    var closing:Bool = false
    
    override func viewDidLoad() {
       // print("ViewDidLoad")
       // super.viewDidLoad()
        closing = false
       
        tableView.frame = startFrame
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basic")
        tableView.dataSource = self
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 12
        tableView.layer.borderWidth = 0.5
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.backgroundColor = UIColor.black
        //tableView.
        
        cancel.frame = startFrame
        cancel.setTitle("Cancel", for: UIControlState.normal)
        cancel.setTitleColor(UIColor.white, for: .normal)
        cancel.isEnabled = true
        cancel.backgroundColor = UIColor.black
        cancel.layer.cornerRadius = 12
        cancel.layer.borderWidth = 0.5
        cancel.layer.borderColor = UIColor.lightGray.cgColor
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refreshControl)
        
        self.view.addSubview(tableView)
        self.view.addSubview(cancel)
        cancel.addTarget(self, action: #selector(self.btn_Cancel(_:)), for: .touchUpInside)
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
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
            self.cancel.frame = CGRect(origin: CGPoint(x: self.tableFrame.origin.x, y: self.tableFrame.origin.y + self.tableFrame.height + 4), size: CGSize(width: self.tableFrame.width, height: 44))
            self.view.alpha = 1.0
        })
    }
    
    @objc func btn_Cancel(_ sender: Any?){
        print("Should remove")
        closing = true
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.frame = self.startFrame
            self.cancel.frame = self.startFrame
            self.view.alpha = 0.2
        }, completion: {finish in
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
        })
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        print("Refreshing")
        
        //self.tableView.reloadData()
        
        
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
       let number = mData.count
        
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellThis = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath as IndexPath)
        cellThis.backgroundColor = UIColor.black
        cellThis.textLabel?.textColor = UIColor.white
        cellThis.textLabel?.text = mData[indexPath.row]
        
        return cellThis
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
    }
    
}
