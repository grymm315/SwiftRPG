# Grymm World
Grymm World is an iOS game written in Swift, featuring a rich narrative and immersive gameplay. This project uses storyboards and focuses on delivering a captivating experience through its various views.

I started this project to further my understanding of good programming concepts rather to make a game that would actually be played. There are no images or assets in this project because I didn't want to get get bogged down with the standard game dev rigamarole.

## Table of Contents
- Features
- Screenshots
- Installation
- Usage
- Contributing
- License

## Features
- ~~Interactive Storytelling: Dive into the world of Grymm and interact with various NPCs through the NPC Dialog system.~~
- Battle System: Engage in battles using the BattleViewController to challenge enemies and progress through the game.
- Character Management: Use the CharacterSheetTableViewController to manage your character's stats and equipment.
- Exploration: Navigate through different rooms and environments using the RoomViewController.
- Credits: A dedicated CreditsViewController to showcase the creators and contributors of Grymm World.

## Screenshots

### Initial View

<img src="https://github.com/grymm315/SwiftRPG/blob/master/TurnBasedRPG/Misc/GrymmWorldTitleScreen.png" width="15%">
- Initial View: Upon launching the game, users are greeted with the InitialViewController, which serves as the main menu of the game. Buttons for New Game, Load Game, Goto Credits, Facebook share
- <img src="https://github.com/grymm315/SwiftRPG/blob/master/TurnBasedRPG/Misc/GrymmWorldRoomScreen.png" width="15%">
- RoomViewController: Use Swipe controls to move through a maze of "Rooms". Respond to different events that occur in these rooms.
- <img src="https://github.com/grymm315/SwiftRPG/blob/master/TurnBasedRPG/Misc/GrymmWorldStatusScreen.png" width="15%">
- CharacterSheetTableViewController: Manage the character's attributes, inventory, skills, quests, etc.
- <img src="https://github.com/grymm315/SwiftRPG/blob/master/TurnBasedRPG/Misc/GrymmWorldBattleScreen.png" width="15%">
- BattleViewController: allows players to engage in combat, using a turn-based system to defeat enemies.

- CreditsViewController: See the list of contributors and game credits. Just credits that scroll.
- ~~NPCDialogViewController: to receive quests, learn about the story, and gain valuable information.~~


## Contributing
Contributions are welcome! If you wish to contribute to Grymm World, please follow these steps:

- Fork the repository.
- Create a new branch for your feature or bugfix.
- Commit your changes and push your branch.
- Submit a pull request for review.
## License
Include your chosen license here, or mention that the project is proprietary.

Feel free to modify the content as needed, especially in the sections where you can add screenshots, specify installation steps, or include additional usage instructions.



## Contents:

- TurnBasedRPG.xcodeProj
- Area - This contains data files from SMAUG, at some point I� d like to parse the information into an Area generator
- Character - Character Data Sheets and the views that interact with them
- Doodles - Contains UIViews with programmatically drawn views. The views are made IBdesignable  so you can use the doodle.xib in an assistant window to see the changes as you make them.
- Room - This started out as a way to explore a binary node tree, but converted to hold room nodes to form a game map.

- MainViewControllers
- InitialViewController


## Support Files
UI Widgets - Reusable UI widgets, like health bars and popup menus


/// 


## To do:

*  Get more contributers
