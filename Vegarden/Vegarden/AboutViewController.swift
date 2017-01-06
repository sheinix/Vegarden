//
//  AboutViewController.swift
//  Vegarden
//
//  Created by Sarah Cleland on 6/01/17.
//  Copyright © 2017 Juan Nuvreni. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UITableViewController {
    
    let dataSource = tableSections()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func setupView() {
                
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifiers.AboutInoCellIdentifier)
        self.tableView.tableHeaderView = aboutAppereance.headerView()
        
        let appereance = aboutAppereance()
        appereance.rateAppBttn.addTarget(self, action: #selector(rateApp), for: .touchUpInside)
        appereance.likeUsFacebookBttn.addTarget(self, action: #selector(likeUs), for: .touchUpInside)
        appereance.sendMailSupportBttn.addTarget(self, action: #selector(sendMail), for: .touchUpInside)
        
        self.tableView.tableFooterView = appereance.footerView()
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return tableSections.sectionNames.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableSections.textsFor(section: section).count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.AboutInoCellIdentifier, for: indexPath)
        
        cell.textLabel?.textColor = aboutAppereance.colorFor(section: indexPath.section)
        cell.textLabel?.font = Fonts.aboutInfoFontText
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = tableSections.textsFor(section: indexPath.section)[indexPath.row]
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return aboutAppereance.headerViewFor(section: section)
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return aboutAppereance.headerHeight
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc public func rateApp() {
        rateApplication(appId: "", completion: {_ in })
    }
    
    @objc public func likeUs() {
       
        UIApplication.shared.open(facebookURL, options: [:]) { (success) in
            
            if !success {
                 self.showAlertView(title: "Oops!", message: "Can't open the page right now!", style: .alert, confirmBlock: {}, cancelBlock: {})
            }
        }
    }
    
    @objc public func sendMail() {
       
        if MFMailComposeViewController.canSendMail() {
            
            let mailComposer = configuredMailComposeViewController()
            self.present(mailComposer, animated: true, completion: nil)
            
        } else {
            self.showAlertView(title: "Oops!", message: "This device can't send emails!", style: .alert, confirmBlock: {}, cancelBlock: {})
        }
        
    }
    
    fileprivate func configuredMailComposeViewController() -> MFMailComposeViewController {
       
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["support@vegarden.com"])
        mailComposerVC.setSubject("Dear Vegarden Team : [Enter your kind words here...]")
        mailComposerVC.setMessageBody("Besides the fact this app is awesome...", isHTML: false)
        
        return mailComposerVC
    }
}

extension AboutViewController : MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
        
        switch result {
        case .sent:
             self.showAlertView(title: "Email Sent!", message: "Thanks! We will take a look at your mail! ", style: .alert, confirmBlock: {}, cancelBlock: {})
        case .failed:
            self.showAlertView(title: "Email Failed to send!", message: "Check your connection and try again! ", style: .alert, confirmBlock: {}, cancelBlock: {})
            
        default: break
            
        }
        
        
    }
}
