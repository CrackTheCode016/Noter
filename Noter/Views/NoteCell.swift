//
//  NoteCell.swift
//  Noter
//
//  Created by Santiago on 9/24/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    @IBOutlet weak var noteTitle: UILabel!
    
    @IBOutlet weak var noteDesc: UILabel!
    
    func updateCell(note: Note) {
        noteTitle.text = note.noteTitle
        noteDesc.text = note.noteContents
    }

}
