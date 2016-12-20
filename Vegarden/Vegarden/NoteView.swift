//
//  NoteView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 5/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

let titleLabelsHeight = 35

class NoteView: RoundedCornersView {
    
    var titleLabel  : UILabel?
    var noteDate    = UILabel()
    var noteTxt     = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization coded
    }
    
    convenience init(frame: CGRect, date: Date, text: String?) {
        
        self.init(frame: frame, date:date, text: text, title: nil)
    
    }
    
    init(frame: CGRect, date: Date, text: String?, title: String?) {

        super.init(frame: frame)
       
        self.backgroundColor   = Colors.notesColor
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.notesColor.cgColor
        self.layer.cornerRadius = 8
        self.applyLightShadow()
        
        noteDate.textAlignment = .right
        noteDate.font = UIFont(name: "TrebuchetMS-Italic", size: 14)
        noteDate.textColor = UIColor.darkGray
        noteDate.text = date.inCellDateFormat()
        
        noteTxt.font = Fonts.notesTextFont
        noteTxt.textColor = UIColor.darkGray
        noteTxt.numberOfLines = 0
        noteTxt.text = text
        
        if (title != nil) {
            
            titleLabel = UILabel()
            titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
            titleLabel?.textColor = UIColor.darkText
            titleLabel?.sizeToFit()
            titleLabel?.text = title
            
           
        }
    
        addSubview(noteDate)
        addSubview(noteTxt)
        
        if (title != nil) {
            addSubview(titleLabel!)
            
            titleLabel?.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(5)
                make.top.equalToSuperview()
                make.height.equalTo(titleLabelsHeight)
                make.right.equalToSuperview()
            }
        }
        
        noteDate.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalTo(((title != nil) ? titleLabel!.snp.bottom : noteDate.superview!.snp.top))
            make.height.equalTo(titleLabelsHeight)
            make.right.equalToSuperview().offset(-7)
        }
        
        
        
//        guard let noteText = noteTxt.text else { return }
//        let txtHeight = noteText.heightWithConstrainedWidth(width: self.bounds.width, font: noteTxt.font)
//        
        noteTxt.snp.makeConstraints { (make) in
            make.top.equalTo(noteDate.snp.bottom)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
