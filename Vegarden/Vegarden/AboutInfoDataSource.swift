//
//  AboutInfoDataSource.swift
//  Vegarden
//
//  Created by Sarah Cleland on 6/01/17.
//  Copyright © 2017 Juan Nuvreni. All rights reserved.
//

import Foundation

public enum sectionNames: Int {
    
    case ThanksSection = 0, TipsSection, SupportSection
}

public struct tableSections {
    
    static let sectionNames = ["Thanks For Using Vegarden Version " + appVersion,
                               "Useful Tips & Tricks",
                               "Support our Project"]

 
    
    static let textSections = [["We believe that everyone should be aware of where their food comes from and what they are really eating. The best way to acheive this is by growing your own food. This app intent to be a simple tool for everyone to learn about food and where it comes from.",
                                "Our Mission is to improve the lifestyle of the people by providing meaningful tools and easy to use gardening assistance to make better food decisions"],
                            ["Check out the Crops database, you can add the crops you want to have a quick access. Once you do, you will see them on My Crops screen",
                                "You can remove the crop that you dont want at any time from My Crops screen",
                                "Plant your crops from My Crop screen!",
                                "On the Life Cycle screen you will see all the planted crops with the percentage completion for the harvest time! ",
                                "You can log every time you weed, water or fertilize a crop ",
                                "If you don't want a crop anymore on the LifeCycle screen because it is dead or unplanted just remove the crop from from the detailed view!",
                                "On MyGarden View you can see all your planted crops and the progress to reach the harvest date!",
                                "You can also add, delete or edit your patchs from the MyGarden screen",
                                "If you need to change, remove or add more rows to a patch you can do it from MyGarden Screen aswell!"],
                                ["This project isn´t funded and all the hard work comes from our love, so we are very grateful that you are using it and we would love to hear about your experience using Vegarden.",
                                                  "All Images has been taken from internet and we do not claim ownership on them, if you found any issue with the images please report to the support email address and we will be in contact to resolve the issue.",
                                                  "There's a few ways on how you can help us keep growing and improving our community! You can spread the word by rating us on the appstore and liking our Facebook Page!"]]

    
    
    
    public static func titleFor(section: Int) -> String {
        
        return tableSections.sectionNames[section]
        
    }
    
    public static func textsFor(section: Int) -> [String]! {
        
        return tableSections.textSections[section]
    
    }
}
