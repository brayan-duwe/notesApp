import Foundation
import Observation

@Observable
class NoteManager {
    var notes: [NoteEntry] = []
    var selectedNote: NoteEntry?
    
    init() {
        self.notes = readJsonFile()
    }
    
    func createNewNote() {
        let newNote = NoteEntry(
            id: UUID(),
            title: "",
            description: "",
            selectedMood: "happy",
            noteDate: Date(),
            mainContent: ""
        )
        notes.append(newNote)
        selectedNote = newNote
    }
}
