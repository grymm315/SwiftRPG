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
    @IBOutlet weak var npcSpeechBubble: UILabel!
    
    var dialogOptions:[String] = [
    "OK- So your not going to believe me but I see subtitles when people talk and I'm just reading the subtitles. Seriously.",
    "Pardon me, I'm looking for some cream",
    "I don't know what to do with myself anymore. It feels like I've been all over the world but nothing seems to make me happy."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dialogList.delegate = self
        dialogList.dataSource = self
        npcSpeechBubble.layer.borderWidth = 2
        npcSpeechBubble.layer.borderColor = UIColor.white.cgColor
        npcSpeechBubble.layer.cornerRadius = 10
        npcSpeechBubble.layer.masksToBounds = true
        
        npcSpeechBubble.text = "  Cindy: What are you looking at? Do I have something on my shirt?"
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dialogOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dialogCell", for: indexPath) as! DialogCell
        cell.configCell(dialogOptions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            npcSpeechBubble.text = "Oh. Teeheehee. Sorry there are a bunch of creepos out there. Did you know that you can tap on text bubbles and wierd things might happen? Oh. Teeheehee. Sorry there are a bunch of creepos out there. Did you know that you can tap on text bubbles and wierd things might happen?Oh. Teeheehee. Sorry there are a bunch of creepos out there. Did you know that you can tap on text bubbles and wierd things might happen?"
        } else if (indexPath.row == 1) {
            npcSpeechBubble.text = "You can check over at Millie's general store. I think she said she was bottling man milk. It's milk for men."
        } else if (indexPath.row == 2) {
            npcSpeechBubble.text = "Unfortunately there is a finite game world at this time. Please help contribute to the making of this game."
        }
    }
    

    
    
}

class DialogCell: UITableViewCell {

    @IBOutlet weak var theText: UILabel!
    
    func configCell(_ text: String) {
        theText.text = text
    }
}
