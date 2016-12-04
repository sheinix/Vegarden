//
//  RowsInfo.swift
//  Vegarden
//
//  Created by Sarah Cleland on 4/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation


//Used for add/remove/edit rows! :
struct RowsInfo {
    
    public enum actionsRow : Int { case Edit, Delete }
    
    var patch : Paddock?     //Patch
    var newRows: [newRow]?    //If new rows added
    var editedRows: [Row]?      //If rows are deleted
    var deletedRows: [Row]?     //If rows are edited
    
    init(paddock: Paddock!) {
        
        patch = paddock
        newRows = []
        editedRows = []
        deletedRows = []
    }
    
    var hasNewRows : Bool {
        get {
            return  ( newRows != nil && newRows!.count > 0)
        }
    }
    
    var hasEditedRows: Bool {
        get {
            return  ( editedRows != nil && editedRows!.count > 0)
        }
    }
    
    var hasDeletedRows: Bool {
        get {
            return  ( deletedRows != nil && deletedRows!.count > 0)
        }
    }
    
    private func rowsEditedIdxFor(row: Row) -> Int {
        
        return (editedRows?.index(where: { $0 === row } ))!
        
    }
    
    public mutating func addEdited(row: Row) {
        
        if let idx = editedRows?.index(where: { $0 === row } ) {
            
            editedRows?.remove(at: idx)
            editedRows?.append(row)
        } else {
            editedRows?.append(row)
        }
    }
}

struct newRow  {
    
    var name: String?
    
}
