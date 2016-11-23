//
//  DetailViewCollectionViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 25/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class DetailViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stageTitle: UILabel!
    @IBOutlet weak var progressStepView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var value2Label: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 8
        
        self.scrollView.delegate = self
        self.scrollView.showsVerticalScrollIndicator = true
      
    }

    public func addStatesNotesWith(dict:Dictionary<String, [Any]>) {
        
        var isGrowing : Bool = true
        var noteView  : NoteView? = nil
    
        if (stageTitle.text == lifeCyclceSates.Seed || stageTitle.text == lifeCyclceSates.Seedling ||
            stageTitle.text == lifeCyclceSates.Harvesting || stageTitle.text == lifeCyclceSates.Finish) {
            
            isGrowing = false
            
        }
        
        let states = dict[stageTitle.text!]!
        
        if (states.count > 0) {
            
            states.forEach({ (state) in
                
                if (isGrowing) {
                    noteView = NoteView(frame: CGRect(x:0,y:0, width:self.frame.width, height:200),
                                         date: (state as! RowLifeState).when as! Date,
                                         text: (state as! RowLifeState).notes as String?,
                                         title:(state as! RowLifeState).nameOfClass)
                } else if (state is Seed || state is Seedling) {
                    
                    noteView = NoteView(frame: CGRect(x:0,y:0, width:self.frame.width, height:200),
                                       date: (state as! CropState).date as Date,
                                       text: (state as! CropState).notes as String?)
                }
                
                if let noteViewUnr = noteView {
                    
                    notesStackView.addArrangedSubview(noteViewUnr)
                }
            })
        }
        
        //TODO Check if this is working right
        
        let newViewsCount = notesStackView.arrangedSubviews.count
        let noteViewHeight = (newViewsCount > 0 ? notesStackView.arrangedSubviews[0].frame.height : 0)
        
        let newHeight = Int(self.frame.height) + (newViewsCount * Int(noteViewHeight))
        
        self.scrollView.contentSize = CGSize(width: self.frame.width, height: CGFloat(newHeight))
        
    }
    
    
}
extension DetailViewCollectionViewCell : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}
