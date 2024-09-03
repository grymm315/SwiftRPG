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
    public var isSelectable:Bool = true
    
    init(_ text:String, completionHandler:@escaping () -> Void){
        name = text
        action = completionHandler
    }
}

class InfoBox: UILabel {
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        self.layer.opacity = 1.0
        self.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.textAlignment = .center
 
        self.layer.backgroundColor = UIColor.black.cgColor
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 6
        self.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.lineBreakStrategy = .pushOut
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)))
    }
}

class PopUp: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView = UITableView()
    public var options:[Command] = []
    //This is the location/size of where the modal begins animation
    //If we set this to the same frame as the button that activates it
    // it will appear jump out from that button
    public var startFrame:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    public var prompt:String?
    
    //This is what the
    var tableFrame:CGRect{
        get {
            return CGRect(origin: CGPoint(x: UIScreen.main.bounds.width * 0.2, y: UIScreen.main.bounds.height / 5), size: CGSize(width: (UIScreen.main.bounds.width * 0.63), height: (UIScreen.main.bounds.height / 2)))
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
//        tableView.layer.borderWidth = 8
//        tableView.layer.borderColor = UIColor.white.cgColor
        tableView.backgroundColor = UIColor.clear

        

        //tableView.
        
        cancel.frame = startFrame
        cancel.setTitle("Cancel", for: UIControl.State.normal)
        cancel.setTitleColor(UIColor.white, for: .normal)
        cancel.isEnabled = true
        cancel.backgroundColor = UIColor.clear
        cancel.layer.cornerRadius = 12
        cancel.layer.borderWidth = 8
        cancel.layer.borderColor = UIColor.lightGray.cgColor
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reload(_:)), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(refreshControl)
        
        self.view.addSubview(tableView)
//        self.view.addSubview(cancel)
        cancel.addTarget(self, action: #selector(self.btn_Cancel(_:)), for: .touchUpInside)
        tableView.refreshControl?.addTarget(self, action: #selector(reload(_:)), for: UIControl.Event.valueChanged)
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
        DispatchQueue.main.async {
            SoundController.shared.tapSound()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.frame = self.startFrame
            self.cancel.frame = self.startFrame
            self.view.alpha = 0.2
        }, completion: {finish in
            self.removeFromParent()
            self.view.removeFromSuperview()
        })
    }
    func updateViews(){
        tableView.reloadData()
    }
    @objc func reload(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
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
        let number = options.count
        
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellThis = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath as IndexPath)
        cellThis.backgroundColor = UIColor(patternImage: UIImage(named: "gradient") ?? UIImage())
        
        cellThis.textLabel?.font = UIFont(name: "Courier New Bold", size: 14)
        cellThis.textLabel?.text = options[indexPath.row].name
        cellThis.textLabel?.numberOfLines = 0
        cellThis.textLabel?.lineBreakMode = .byWordWrapping
        cellThis.textLabel?.lineBreakStrategy = .pushOut
        cellThis.textLabel?.sizeToFit()
        if (options[indexPath.row].isSelectable){
            cellThis.textLabel?.textAlignment = .right
            cellThis.textLabel?.textColor = UIColor.white
            cellThis.backgroundView = nil
        } else {
            cellThis.textLabel?.textAlignment = .left
            cellThis.backgroundView = UIImageView(image: UIImage(named: "frame"))
            cellThis.textLabel?.textColor = UIColor.systemGreen
            cellThis.selectionStyle = .none
        }
        
        return cellThis
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (options[indexPath.row].isSelectable){
            options[indexPath.row].action()
            btn_Cancel(self)
        } else {
            print("This was not selectable")
        }
//        self.view.removeFromSuperview()
    }
    
}
