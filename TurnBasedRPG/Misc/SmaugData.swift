//
//  Build.swift
//  TurnBasedRPG
//
//  Created by Christopher Phillips on 8/26/18.
//  Copyright © 2018 Chris Phillips. All rights reserved.
//

import Foundation
//** This data was mined from SMAUG */
class Build{
    
    let ex_pmisc:[String] =
        [ "undefined", "vortex", "vacuum", "slip", "ice", "mysterious"]
    
    let ex_pwater:[String] = [ "current", "wave", "whirlpool", "geyser" ]
    
    let ex_pair:[String] = [ "wind", "storm", "coldwind", "breeze" ]
    
    let ex_pearth:[String] =
        [ "landslide", "sinkhole", "quicksand", "earthquake" ]
    
    let ex_pfire:[String] = [ "lava", "hotair" ]
    
    
    let ex_flags:[String] = [
        "isdoor", "closed", "locked", "secret", "swim", "pickproof", "fly", "climb",
        "dig", "eatkey", "nopassdoor", "hidden", "passage", "portal", "r1", "r2",
        "can_climb", "can_enter", "can_leave", "auto", "noflee", "searchable",
        "bashed", "bashproof", "nomob", "window", "can_look", "isbolt", "bolted"
    ]
    
   
    
    let r_flags:[String] = [
        "dark", "death", "nomob", "indoors", "house", "neutral", "chaotic",
        "nomagic", "nolocate", "private", "safe", "solitary", "petshop", "norecall",
        "donation", "nodropall", "silence", "logspeech", "nodrop", "clanstoreroom",
        "nosummon", "noastral", "teleport", "teleshowdesc", "nofloor",
        "nosupplicate", "arena", "nomissile", "auction", "nohover", "prototype",
        "dnd", "_track_", "light", "nolog", "color", "nowhere", "noyell", "noquit",
        "notrack", "nosuppcorpse",
        "map",
        "nosupprecall",
    ]
    
    let o_flags:[String] = [
        "glow", "hum", "dark", "loyal", "evil", "invis", "magic", "nodrop", "bless",
        "antigood", "antievil", "antineutral", "noremove", "inventory",
        "antimage", "antithief", "antiwarrior", "anticleric", "organic", "metal",
        "donation", "clanobject", "clancorpse", "antivampire", "antidruid",
        "hidden", "poisoned", "covering", "deathrot", "buried", "prototype",
        "nolocate", "groundrot", "lootable", "permanent", "multi_invoke",
        "deathdrop", "skinned", "nofill", "blackened", "noscavenge",
        "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10"
    ]
    
    let container_flags:[String] =
        [
            "closeable", "pickproof", "closed", "locked", "eatkey"
    ]
    
    
    let mag_flags:[String] = [
        "returning", "backstabber", "bane", "loyal", "haste", "drain",
        "lightning_blade",
        "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10"
    ]
    
    let wear_flags:[String] = [
        "take", "finger", "neck", "body", "head", "legs", "feet", "hands", "arms",
        "shield", "about", "waist", "wrist", "wield", "hold", "_dual_", "ears",
        "eyes", "missile", "back", "face", "ankle"
    ]
    
    let item_w_flags:[String] = [
        "take", "finger", "neck", "neck", "neck", "body", "head", "legs", "feet",
        "hands", "arms", "shield", "about", "waist", "wrist", "wrist", "wield",
        "hold", "dual", "ears", "eyes", "missile", "back", "face", "ankle", "ankle",
    ]
    
    let area_flags:[String] = [
        "nopkill", "freekill", "noteleport", "spelllimit", "silence", "nosummon",
        "scrap", "hidden", "nowhere", "newbie", "nohover", "nologout", "noportalin",
        "noportalout", "noastral", "nomagic"
    ]
    
    let o_types:[String] = [
        "none", "light", "scroll", "wand", "staff", "weapon", "_fireweapon",
        "_missile",
        "treasure", "armor", "potion", "_worn", "furniture", "trash", "_oldtrap",
        "container", "_note", "drinkcon", "key", "food", "money", "pen", "boat",
        "corpse", "corpse_pc", "fountain", "pill", "blood", "bloodstain",
        "scraps", "pipe", "herbcon", "herb", "incense", "fire", "book", "switch",
        "lever", "pullchain", "button", "dial", "rune", "runepouch", "match",
        "trap",
        "map", "portal", "paper", "tinder", "lockpick", "spike", "disease", "oil",
        "fuel", "puddle", "abacus", "missileweapon", "projectile", "quiver",
        "shovel", "salve", "cook", "keyring", "odor", "chance",
        "piece", "housekey", "journal", "mixture",
        
    ]
    
    let a_types:[String] = [
        "none", "strength", "dexterity", "intelligence", "wisdom", "constitution",
        "sex", "class", "level", "age", "height", "weight", "mana", "hit", "move",
        "gold", "experience", "armor", "hitroll", "damroll", "save_poison",
        "save_rod",
        "save_para", "save_breath", "save_spell", "charisma", "affected",
        "resistant",
        "immune", "susceptible", "weaponspell", "luck", "backstab", "pick", "track",
        "steal", "sneak", "hide", "palm", "detrap", "dodge", "peek", "scan",
        "gouge",
        "search", "mount", "disarm", "kick", "parry", "bash", "stun", "punch",
        "climb",
        "grip", "scribe", "brew", "wearspell", "removespell", "emotion",
        "mentalstate",
        "stripsn", "remove", "dig", "full", "thirst", "drunk", "blood", "cook",
        "recurringspell", "contagious", "xaffected", "odor", "roomflag",
        "sectortype",
        "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10"
    ]
    
    let a_flags:[String] = [
        "blind", "invisible", "detect_evil", "detect_invis", "detect_magic",
        "detect_hidden", "hold", "sanctuary", "faerie_fire", "infrared", "curse",
        "_flaming", "poison", "protect", "_paralysis", "sneak", "hide", "sleep",
        "charm", "flying", "pass_door", "floating", "truesight", "detect_traps",
        "scrying", "fireshield", "shockshield", "r1", "iceshield", "possess",
        "berserk", "aqua_breath", "recurringspell", "contagious", "acidmist",
        "venomshield", "grapple"
    ]
    
    let act_flags:[String] = [
        "npc", "sentinel", "scavenger", "nolocate", "r2", "aggressive", "stayarea",
        "wimpy", "pet", "train", "practice", "immortal", "deadly", "polyself",
        "meta_aggr", "guardian", "running", "nowander", "mountable", "mounted",
        "scholar", "secretive", "hardhat", "mobinvis", "noassist", "autonomous",
        "pacifist", "noattack", "annoying", "statshield", "prototype", "nosummon",
        "nosteal", "r2", "infested", "free2", "blocking", "is_clone",
        "is_dreamform", "is_spiritform", "is_projection", "stopscript",
        
        "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10"
    ]
    
    let pc_flags:[String] = [
        "r1", "deadly", "unauthed", "norecall", "nointro", "gag", "retired",
        "guest",
        "nosummon", "pager", "notitled", "groupwho", "diagnose", "highgag", "",
        "nstart", "dnd", "idle", "nobio", "nodesc", "beckon", "noexp", "nobeckon",
        "hints", "nohttp", "freekill"
    ]
    
    let plr_flags:[String] = [
        "npc", "boughtpet", "shovedrag", "autoexits", "autoloot", "autosac",
        "blank",
        "outcast", "brief", "combine", "prompt", "telnet_ga", "holylight",
        "wizinvis", "roomvnum", "silence", "noemote", "attacker", "notell", "log",
        "deny", "freeze", "thief", "killer", "litterbug", "ansi", "rip", "nice",
        "flee", "autogold", "automap", "afk", "invisprompt", "roomvis", "nofollow",
        "landed", "blocking", "is_clone", "is_dreamform", "is_spiritform",
        "is_projection", "cloak", "compass", "nohomepage",
    ]
    
    let trap_flags:[String] = [
        ("room"), ("obj"), ("enter"), ("leave"), ("open"), ("close"), ("get"), ("put"), ("pick"),
        ("unlock"), ("north"), ("south"), ("east"), ("west"), ("up"), ("down"), ("examine"),
        ("northeast"), ("northwest"), ("southeast"), ("southwest")
    ]
    
    let cmd_flags:[String] = [
        "possessed", "polymorphed", "watch", "retired", "noabort", "r4", "r5", "r6",
        "r7",
        "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15", "r16", "r17", "r18",
        "r19", "r20", "r21", "r22", "r23", "r24", "r25", "r26", "r27", "r28", "r29",
        "r30"
    ]
    
    let wear_locs:[String] = [
        "light", "finger1", "finger2", "neck1", "neck2", "body", "head", "legs",
        "feet", "hands", "arms", "shield", "about", "waist", "wrist1", "wrist2",
        "wield", "hold", "dual_wield", "ears", "eyes", "missile_wield", "back",
        "face", "ankle1", "ankle2"
    ]
    
    let ris_flags:[String] = [
        "fire", "cold", "electricity", "energy", "blunt", "pierce", "slash", "acid",
        "poison", "drain", "sleep", "charm", "hold", "nonmagic",
        "plus1", "plus2", "plus3", "plus4", "plus5", "plus6", "magic", "paralysis",
        "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10"
    ]
    
    let trig_flags:[String] = [
        ("up"), ("unlock"), ("lock"), ("d_north"), ("d_south"), ("d_east"), ("d_west"), ("d_up"),
        ("d_down"), ("door"), ("container"), ("open"), ("close"), ("passage"), ("oload"), ("mload"),
        ("teleport"), ("teleportall"), ("teleportplus"), ("death"), ("cast"), ("fakeblade"),
        "rand4", "rand6", ("trapdoor"), ("anotherroom"), ("usedial"), ("absolutevnum"),
        ("showroomdesc"), ("autoreturn"), "r2", "r3"
    ]
    
    let part_flags:[String] = [
        "head", "arms", "legs", "heart", "brains", "guts", "hands", "feet",
        "fingers",
        "ear", "eye", "long_tongue", "eyestalks", "tentacles", "fins", "wings",
        "tail", "scales", "claws", "fangs", "horns", "tusks", "tailattack",
        "sharpscales", "beak", "haunches", "hooves", "paws", "forelegs", "feathers",
    ]
    
    let attack_flags:[String] = [
        "bite", "claws", "tail", "sting", "punch", "kick", "trip", "bash", "stun",
        "gouge", "backstab", "feed", "drain", "firebreath", "frostbreath",
        "acidbreath", "lightnbreath", "gasbreath", "poison", "nastypoison", "gaze",
        "blindness", "causeserious", "earthquake", "causecritical", "curse",
        "flamestrike", "harm", "fireball", "colorspray", "weaken", "spiralblast",
        "pounce", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10"
    ]
    
    let defense_flags:[String] = [
        "parry", "dodge", "heal", "curelight", "cureserious", "curecritical",
        "dispelmagic", "dispelevil", "sanctuary", "fireshield", "shockshield",
        "shield", "bless", "stoneskin", "teleport", "monsum1", "monsum2", "monsum3",
        "monsum4", "disarm", "iceshield", "grip", "truesight", "r4", "r5", "r6",
        "r7",
        "r8", "r9", "r10", "r11", "r12", "acidmist", "venomshield", "r1", "r2",
        "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10"
    ]
    
    
    let mprog_flags:[String] = [
        "act", "speech", "rand", "fight", "death", "hitprcnt", "entry", "greet",
        "allgreet", "give", "bribe", "hour", "time", "wear", "remove", "sac",
        "look", "exa", "zap", "get", "drop", "damage", "repair", "randiw",
        "speechiw", "pull", "push", "sleep", "rest", "leave", "script", "use",
        "load", "login", "void", "tell", "imminfo", "greetinfight", "move",
        "command", "sell", "emote", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8",
        "r9", "r10"
    ]
    
}
