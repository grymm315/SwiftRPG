//
//  NPCDialogViewController.swift
//  TurnBasedRPG
//
//  Created by Chris Phillips on 1/24/24.
//  Copyright © 2024 Chris Phillips. All rights reserved.
//

import UIKit

class NpcDialogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var npcImage: UIImageView!
    @IBOutlet weak var dialogList: UITableView!
    @IBOutlet weak var npcSpeechBubble: UILabel!
    
//    @IBOutlet weak var scrollView: UIScrollView!
    
    var dialogOptions:[String] = [
    "OK- So your not going to believe me but I see subtitles when people talk and I'm just reading the subtitles. Seriously.",
    "Pardon me, I'm looking for some cream",
    "I don't know what to do with myself anymore. It feels like I've been all over the this world but nothing seems to spark joy."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dialogList.delegate = self
        dialogList.dataSource = self
        npcSpeechBubble.text = "What are you looking at? Do I have something on my shirt?"
        
    }
    func reportScreen(){
        print("Screen: \(UIScreen.main.bounds.width), \(UIScreen.main.bounds.height)")
        print("Image should be \(getImageFrame().width) , \(getImageFrame().height)")
    }
    
    // When constraints ain't cutting it we will forcefully set frames
    func getImageFrame() -> CGRect{
        var rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.39)
        
        if (UIScreen.main.bounds.width > UIScreen.main.bounds.height){
            rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.39, height: UIScreen.main.bounds.height)
        }
        return rect
    }
    
    func getSpeechFrame() -> CGRect{
        var rect = CGRect(x: 8, y: UIScreen.main.bounds.height * 0.24, width: UIScreen.main.bounds.width - 16, height: 10)
        
        if (UIScreen.main.bounds.width > UIScreen.main.bounds.height){
            rect = CGRect(x: 8, y: UIScreen.main.bounds.width * 0.24, width: ((UIScreen.main.bounds.width * 0.39) - 16), height: 10)
        }
        return rect
    }
    func getTableFrame() -> CGRect{
        //Portrait
        var rect = CGRect(x: 0, y: getImageFrame().height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.61)
        //Landscape
        if (UIScreen.main.bounds.width > UIScreen.main.bounds.height){
            rect = CGRect(x: getImageFrame().width, y: 0, width: UIScreen.main.bounds.width * 0.61, height: UIScreen.main.bounds.height)
        }
        return rect
    }
    

    
    override func viewDidLayoutSubviews() {
        npcImage.frame = getImageFrame()
        dialogList.frame = getTableFrame()
        npcSpeechBubble.frame = getSpeechFrame()
        npcSpeechBubble.sizeToFit()

        reportScreen()
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
        var speech = ""
        if (indexPath.row == 0) {
            speech = "Teeheehee. Sorry there are a bunch of creepos out there. Did you know that you can tap on text bubbles and wierd things might happen?"
        } else if (indexPath.row == 1) {
            speech = "You can check over at Millie's general store. I think she said she was bottling man milk. It's milk for men."
        } else if (indexPath.row == 2) {
            speech = "Unfortunately there is a finite game world at this time. Please help contribute to the making of this game."
        } else {
            speech = "I don't speak stupid"
        }
        dialogOptions[0] = speech
        npcSpeechBubble.text = speech
        npcSpeechBubble.sizeToFit()
    }
}

class DialogCell: UITableViewCell {

    @IBOutlet weak var theText: UILabel!
    
    func configCell(_ text: String) {
        theText.text = text
    }
}
