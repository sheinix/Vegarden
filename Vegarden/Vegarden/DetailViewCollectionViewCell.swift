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
    
        if (stageTitle.text == lifeCyclceSates.Planted ||
            stageTitle.text == lifeCyclceSates.Harvesting || stageTitle.text == lifeCyclceSates.Finish) {
            
            isGrowing = false
            
        }
        
        let states = dict[stageTitle.text!]!
        
        if (states.count > 0) {
            
            states.forEach({ (state) in
                
                if (isGrowing) {
                    
                    guard !(state as! RowLifeState).isBeenDeleted else { return }
                    
                    noteView = createNoteFromRow((lifeState: state as! RowLifeState))
                
                } else if (state is Seed || state is Seedling) {
                    
                    noteView = createNoteFromCrop(cropState: (state as! CropState))
                    
                }
                
                if let noteViewUnr = noteView {
                    
                  let newHeightSize = scrollView.contentSize.height + noteViewUnr.frame.height
                  notesStackView.addArrangedSubview(noteViewUnr)
                    
                    self.stackViewHeight.constant = newHeightSize
                    scrollView.contentSize = CGSize(width: notesStackView.frame.width,
                                                    height: CGFloat(newHeightSize))                    
                }
            })
        }
        
    }
    
    //TODO : THIS IS ABSOLUTELY SHIT! CODE REPETEAD UNNECESARRY, CHANGE IT, NOT TIME FOR NOW, DID A QUICK FIX!
    
    fileprivate func createNoteFromCrop(cropState: CropState) -> NoteView {
        
        var newHeight : CGFloat?
        
        if (cropState.notes != nil) {
            
            newHeight = noteHeight +  (cropState.notes?.heightWithConstrainedWidth(width: self.notesStackView.frame.width, font: Fonts.notesTextFont))!
            
        } else {
            
            newHeight = noteHeight + 10
        }
        
        
        let frame = CGRect(x:0,y:0, width:self.notesStackView.frame.width, height:newHeight!)
        
        return  NoteView(frame:frame,
                         date: cropState.date!,
                         text: cropState.notes as String?,
                         title:"Planted from " + cropState.nameOfClass)
    }
    
    
    fileprivate func createNoteFromRow(lifeState: RowLifeState) -> NoteView {
        
        var newHeight : CGFloat?
        
        if (lifeState.notes != nil) {
            
            newHeight = noteHeight +  (lifeState.notes?.heightWithConstrainedWidth(width: self.notesStackView.frame.width, font: Fonts.notesTextFont))!
            
        } else {
            
            newHeight = noteHeight
        }
        
    
        let frame = CGRect(x:0,y:0, width:self.notesStackView.frame.width, height:newHeight!)
        
        return  NoteView(frame:frame,
                          date: lifeState.when!,
                          text: lifeState.notes as String?,
                         title:lifeState.nameOfClass)
        
    }
}

extension DetailViewCollectionViewCell : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}
