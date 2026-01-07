import Foundation
import SwiftUI
import AppKit

let fileManager  = FileManager.default
let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
let noteName = listJsonFiles()


struct NoteEntry: Codable, Identifiable, Hashable{
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
        let existentes = readJsonFile()
        print(existentes)

        if !data.title.isEmpty{
            filename = "\(data.title).json"
        }
        
        let fileURL = documentPath.appendingPathComponent(filename)
        try encodeData.write(to: fileURL)
        
    } catch {
        print(error.localizedDescription)
    }
}

func listJsonFiles() -> [String]{
    do {
        let allFiles = try fileManager.contentsOfDirectory(at: documentPath, includingPropertiesForKeys: nil)
        let eachNote = allFiles.map{$0.lastPathComponent}.filter({$0.hasSuffix("json")})
        return eachNote
    }
    catch {
        print("Error loading files: \(error.localizedDescription)")
        return []
    }
}

func readJsonFile() -> [NoteEntry] {
    let allFiles = listJsonFiles()
    var notes: [NoteEntry] = []
    for file in allFiles {
        do{
            let fileURL = documentPath.appendingPathComponent(file)
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let note = try decoder.decode(NoteEntry.self, from: data)
            notes.append(note)
        } catch {
            print(error)
        }
    }
    return notes
}


func openAndSelectFile(){
    NSWorkspace.shared.open(documentPath)
}
