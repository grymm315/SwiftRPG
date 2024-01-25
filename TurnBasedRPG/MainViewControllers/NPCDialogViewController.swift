//
//  NPCDialogViewController.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 1/24/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import UIKit

class NPCDialogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var npcImage: UIImageView!
    @IBOutlet weak var dialogList: UITableView!
    var dialogOptions:[String] = [
    "Does the train stop near here?",
    "Pardon me, I'm looking for some cream",
    "I don't know what to do with myself anymore. It feels like I've been all over the world but nothing seems to make me happy."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dialogList.delegate = self
        dialogList.dataSource = self
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dialogOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dialogCell", for: indexPath) as! DialogCell
        cell.configCell(dialogOptions[indexPath.row])
        return cell
    }
    

    
    
}

class DialogCell: UITableViewCell {

    @IBOutlet weak var theText: UILabel!
    
    func configCell(_ text: String) {
        theText.text = text
    }
}
