//
//  NoteView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 5/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

let titleLabelsHeight = 40

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
        
        if (title != nil) {
            
            titleLabel = UILabel()
            titleLabel?.sizeToFit()
            titleLabel?.text = title
           
        }
    
        self.backgroundColor   = Colors.notesColor
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 6
        
        
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
            make.right.equalToSuperview()
        }
        
        
        noteTxt.snp.makeConstraints { (make) in
            make.top.equalTo(noteDate.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(0) //need to update this when animation zooms in
        }
        
        noteDate.text = date.inCellDateFormat()
        noteTxt.text = text
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
