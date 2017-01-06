//
//  AboutInfoAppereace.swift
//  Vegarden
//
//  Created by Sarah Cleland on 6/01/17.
//  Copyright © 2017 Juan Nuvreni. All rights reserved.
//

import Foundation
import SnapKit

public struct aboutAppereance {
    
    public var rateAppBttn        = UIButton(type: .custom)
    public var likeUsFacebookBttn = UIButton(type: .custom)
    public var sendMailSupportBttn = UIButton(type: .custom)
    
    static let headerHeight = CGFloat(100)
    let footerHeight = CGFloat(60)
    let buttonsWidth = (screenWidth / 3) * 0.8
    
    static let colorSections = [Colors.mainColorUI,
                               Colors.fertilizeColor,
                               Colors.waterColor]
    
    public static func colorFor(section: Int) -> UIColor {
        
        return colorSections[section]
    }
    
    public static func headerViewFor(section: Int) -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: headerHeight))
        headerView.backgroundColor = UIColor.white
        
        let titleLabel = UILabel(frame: CGRect.zero)
        
        titleLabel.textColor = colorFor(section: section)
        titleLabel.font = Fonts.aboutInfoFontTitle
        titleLabel.textAlignment = .center
        titleLabel.text = tableSections.titleFor(section: section)
        
        headerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 10, bottom: -10, right: -20))
        }
        
        return headerView
    
    }
    
    public static func headerView() -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: headerHeight))
        
        let titleLabel = UILabel(frame: CGRect.zero)
        
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = Fonts.aboutInfoFontTitle
        titleLabel.textAlignment = .center
        titleLabel.text = "About Us"
        
        headerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 10, bottom: -10, right: -20))
        }
        
        return headerView
        
    }

    public func footerView() -> UIView {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: footerHeight))
        
        rateAppBttn.setTitle("Rate Vegarden!", for: .normal)
        likeUsFacebookBttn.setTitle("Like Us on Facebook", for: .normal)
        sendMailSupportBttn.setTitle("support@vegarden.com", for: .normal)
        
        rateAppBttn.setRoundedCornerStyledWith(borderColor: Colors.mainColor, textColor: Colors.mainColorUI)
        likeUsFacebookBttn.setRoundedCornerStyledWith(borderColor: UIColor.blue.cgColor, textColor: UIColor.blue)
        sendMailSupportBttn.setRoundedCornerStyledWith(borderColor: Colors.waterColor.cgColor, textColor: Colors.waterColor)
        
        footerView.addSubview(rateAppBttn)
        footerView.addSubview(likeUsFacebookBttn)
        footerView.addSubview(sendMailSupportBttn)
        
        rateAppBttn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(buttonsWidth)
        }
        
        likeUsFacebookBttn.snp.makeConstraints { (make) in
            make.left.equalTo(rateAppBttn.snp.right).offset(5)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(buttonsWidth)
        }
        
        sendMailSupportBttn.snp.makeConstraints { (make) in
            make.left.equalTo(likeUsFacebookBttn.snp.right).offset(5)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-10)
        }
        
        return footerView
        
    }
    
   }
