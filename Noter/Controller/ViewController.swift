
import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    var fetchController: NSFetchedResultsController<Note>!
    
    @IBOutlet weak var noteTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        noteTable.delegate = self
        noteTable.dataSource = self
        self.navigationItem.title = "Noter"
        
//        let note = Note(context: context)
//
//
//        note.noteTitle = "I had a good day."
//        note.noteContents = "Today I had a cheeseburger."

      
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NoteDetail" {
            if let detailVC = segue.destination as? NoteDetailVC {
                if let note = sender as? Note {
                    detailVC.editNote = note
                }
            }
        }
    }
    
    func fetch() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let titleSort = NSSortDescriptor(key: "noteTitle", ascending: true)
        fetchRequest.sortDescriptors = [titleSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ad.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)

        self.fetchController = controller
        controller.delegate = self
      
        do {
            try controller.performFetch()
        }
        
        catch {
            
            let error  = error as NSError
            print("\(error)")
        }
        ad.saveContext()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchController.sections?.count {
            return sections

        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let notes = fetchController.fetchedObjects {
            let item = notes[indexPath.row]
            performSegue(withIdentifier: "NoteDetail", sender: item)

        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchController.sections {
            let section = sections[section]
            return section.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = noteTable.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteCell {
            configureNoteCell(note: cell, indexPath: indexPath as NSIndexPath)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func configureNoteCell(note: NoteCell, indexPath: NSIndexPath) {
        let noteCell = fetchController.object(at: indexPath as IndexPath)
        note.updateCell(note: noteCell)
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        noteTable.beginUpdates()
        ad.saveContext()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        noteTable.endUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
        case.insert:
            if let indexPath = newIndexPath {
                noteTable.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case.delete:
        if let indexPath = indexPath {
            noteTable.deleteRows(at: [indexPath], with: .fade)
            }
            break
        
        case.update:
        if let indexPath = indexPath {
            let cell = noteTable.cellForRow(at: indexPath) as! NoteCell
            configureNoteCell(note: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                noteTable.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let indexPath = newIndexPath {
                noteTable.insertRows(at: [indexPath], with: .fade)
            }
            break
            
            
        }
    }
    

}

