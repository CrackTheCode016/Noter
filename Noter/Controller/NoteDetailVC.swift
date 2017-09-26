//
//  NoteDetailVC.swift
//  Noter
//
//  Created by Santiago on 9/25/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit

class NoteDetailVC: UIViewController {
    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var noteContentField: UITextField!
    var editNote: Note!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edit()
        self.navigationItem.title = "Noter"

    }
    
    func edit() {
        if editNote != nil {
            noteTitleField.text = editNote.noteTitle
            noteContentField.text = editNote.noteContents
        }
    }
  
    @IBAction func savePress(_ sender: Any) {
        var note: Note!
        if editNote != nil {
            note = editNote
        }
        else {
            note = Note(context: context)
        }
        if let title = noteTitleField.text {
            note.noteTitle = title

        }
        
        if let content = noteContentField.text {
            note.noteContents = content

        }
    
        
        _ = navigationController?.popViewController(animated: true)
    }
        
    @IBAction func trashPressed(_ sender: Any) {
        if editNote != nil {
            context.delete(editNote)
        }
        _ = navigationController?.popViewController(animated: true)

    }
}
