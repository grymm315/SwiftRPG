I started this project to further my understanding of good programming concepts rather to make a game that would actually be played. There are no images or assets in this project  because I didn� t want to get get bogged down with the standard game dev rigamarole.Contents:TurnBasedRPG.xcodeProjArea - This contains data files from SMAUG, at some point I� d like to parse the information into an Area generatorCharacter - Character Data Sheets and the views that interact with themDoodles - Contains UIViews with programmatically drawn views. The views are made IBdesignable  so you can use the doodle.xib in an assistant window to see the changes as you make them.Room - This started out as a way to explore a binary node tree, but converted to hold room nodes to form a game map.Support FilesUI Widgets - Reusable UI widgets, like health bars and popup menus/// To do:*  Rid the project of segues! Adopt a coordinator pattern. Yes...wonderful!