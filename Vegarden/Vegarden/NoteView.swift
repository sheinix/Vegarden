//
//  NoteView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 5/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

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
        
        noteDate.text = date.inCellDateFormat()
        noteTxt.text = text
        
        if (title != nil) {
            
            titleLabel = UILabel()
            titleLabel?.text = title
        }
    
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.yellow
        
        addSubview(noteDate)
        addSubview(noteTxt)
        
        if (title != nil) {
            addSubview(titleLabel!)
        
            titleLabel?.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.top.equalToSuperview()
                make.height.equalTo(50)
                make.width.equalTo(200)
            }
        }
        
        noteDate.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(((title != nil) ? titleLabel!.snp.bottom : noteDate.superview!.snp.top))
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        noteTxt.snp.makeConstraints { (make) in
            make.top.equalTo(noteDate.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
