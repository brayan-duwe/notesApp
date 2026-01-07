import SwiftUI

struct ContentView: View {
    @State private var manager = NoteManager()

    var body: some View {
        
        NavigationSplitView {
            if !manager.notes.isEmpty {
                List(manager.notes, selection: $manager.selectedNote){ note in
                    Section{
                        NavigationLink(value: note) {
                            Text(note.title)
                                .font(.system(size: 18))
                        }
                    }
                }
                .padding(24)
                .safeAreaInset(edge: .top){
                    Button{
                        manager.createNewNote()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 18))
                        Text("New note")
                            .font(.system(size: 18))
                    }
                    .glassEffect()
                    .cornerRadius(24)
                }
            } else {
                Text("Here you will see your manager.notes")
                    .font(.system(size: 18, weight: .semibold, design: .default))
                    .foregroundColor(Color.gray)
                
                    .onAppear {
                        let existentNotes = readJsonFile()
                        self.manager.notes = existentNotes
                    }
            }
        } detail: {
            if let note = manager.selectedNote {
                NoteDetailedView(note: binding(for: note))
            } else {
                Text("Select a note")
            }
        }
        
    }
    private func binding(for note: NoteEntry) -> Binding<NoteEntry> {
        guard let index = manager.notes.firstIndex(where: { $0.id == note.id}) else {
            fatalError("Note not found")
        }
        return $manager.notes[index]
    }
}
#Preview {
    ContentView()
}
