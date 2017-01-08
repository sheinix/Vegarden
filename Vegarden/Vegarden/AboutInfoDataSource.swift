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

 
    
    static let textSections = [["We believe that everyone should be aware of where their food comes from and what they are eating. The best way to acheive this is by growing your own food. This app intents to be a simple tool for everyone, whether you are a beginner or a bit more advanced, to assist in your veggie gardening", "Our Mission is to improve the lifestyle of the people by providing meaningful tools and easy to use gardening assistance to make better food decisions"],
                            ["Swipe right to access the side bar",
                             "Check out the Database - there you can choose the plants you want to grow and add them to the My Crops screen for quick access",
                             "Remove the plants that you dont want at anytime from My Crops screen ",
                             "Plant vegetables from the My Crops screen ",
                             "LifeCycle screen shows all your planted crops with the percentage progress to harvest! ",
                             "On the LifeCycle screen you can log every time you weed, water or fertilize a crop by tapping on the vegetable cell and using the + button",
                             "If you want to remove a crop from the LifeCycle screen tap onthe vegetable cell, use the + button and choose Remove",
                             "MyGarden View shows all your planted crops and the progress to reach harvest!",
                             "Add, edit or delete your patches and rows from the MyGarden screen"],
                            ["This project isn´t funded and all the hard work comes from our passion for making growing your own food easy, so we are very grateful that you are using it and would love to hear about your experience using Vegarden. ",
                            "All Images have been taken from internet and we do not claim ownership on them, if you have any issues with the images please report to the support email address and we will be in contact to resolve the issue.",
                            "To help us keep improve and grow our communtiy you can rate us on the appstore and like our Facebook Page!"]]

    
    public static func titleFor(section: Int) -> String {
        
        return tableSections.sectionNames[section]
        
    }
    
    public static func textsFor(section: Int) -> [String]! {
        
        return tableSections.textSections[section]
    
    }
}
