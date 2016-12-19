//
//  DetailViewCollectionViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 25/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SnapKit

let defaultStackViewHeight = 109
let noteHeight = CGFloat(integerLiteral:80)

class DetailViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stageTitle: UILabel!
    //@IBOutlet weak var progressStepView: UIView!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    
  //  @IBOutlet weak var bottomLimit: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.scrollView.delegate = self
        self.scrollView.showsVerticalScrollIndicator = true
        self.scrollView.isDirectionalLockEnabled = true
        self.scrollView.alwaysBounceHorizontal = false
        self.scrollView.showsHorizontalScrollIndicator = false

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        notesStackView.arrangedSubviews.forEach( { notesStackView.removeArrangedSubview($0) } )
        notesStackView.subviews.forEach( { $0.removeFromSuperview() } )
        stackViewHeight.constant = CGFloat(defaultStackViewHeight)
        scrollView.contentSize = CGSize.zero
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
                    
                    guard !(state as! RowLifeState).isBeenDeleted else { return }
                    
                    noteView = NoteView(frame: CGRect(x:0,y:0, width:self.notesStackView.frame.width, height:noteHeight),
                                         date: (state as! RowLifeState).when!,
                                         text: (state as! RowLifeState).notes as String?,
                                         title:(state as! RowLifeState).nameOfClass)
                } else if (state is Seed || state is Seedling) {
                    
                    noteView = NoteView(frame: CGRect(x:0,
                                                      y:0,
                                                  width:self.notesStackView.frame.width,
                                                 height:noteHeight),
                                       date: (state as! CropState).date as Date,
                                       text: (state as! CropState).notes as String?,
                                       title: "Planted from " + (state as! CropState).nameOfClass)
                }
                
                if let noteViewUnr = noteView {
                    
                  let newHeightSize = scrollView.contentSize.height + noteHeight //+ 20
                  notesStackView.addArrangedSubview(noteViewUnr)
                    
                    self.stackViewHeight.constant = newHeightSize
                    //self.bottomLimit.constant -= newHeightSize
                    //self.notesStackView.frame.size.height = newHeightSize
                    
                    scrollView.contentSize = CGSize(width: notesStackView.frame.width,
                                                    height: CGFloat(newHeightSize))
                    
                    
//                    scrollView.layoutSubviews()
                    
                }
            })
        }
        
    }
}

extension DetailViewCollectionViewCell : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}
