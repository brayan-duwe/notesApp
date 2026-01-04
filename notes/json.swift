import Foundation
import AppKit

let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

struct NoteEntry: Codable {
    var id = UUID()
    var title: String
    var description: String
    var selectedMood: String
    var noteDate: Date
    var mainContent: String
}

func saveNote(noteTitle: String, noteDescription: String, noteMood: String, noteDate: Date, noteContent: String) {
    let note = NoteEntry(
        title: noteTitle,
        description: noteDescription,
        selectedMood: noteMood,
        noteDate: noteDate,
        mainContent: noteContent,
    )
    writeJsonFile(data: note)
}


func writeJsonFile(data: NoteEntry) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    encoder.dateEncodingStrategy = .iso8601
    do {
        let encodeData = try encoder.encode(data)
        var filename = "untitled.json"

        if !data.title.isEmpty{
            filename = "\(data.title).json"
        }
        
        let fileURL = documentPath.appendingPathComponent("\(filename)")
        try encodeData.write(to: fileURL)
        
    } catch {
        print(error.localizedDescription)
    }
}

func readJsonFile(){
    
}

func openAndSelectFile(){
    NSWorkspace.shared.open(documentPath)
}
