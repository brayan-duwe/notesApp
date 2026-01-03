import SwiftUI

struct ContentView: View {
    @State private var Title: String = ""
    @State private var Description: String = ""
    @State private var SelectedMood: Mood = .happy
    @State private var NoteDate = Date()
    @State private var MainContent: String = ""
    @State private var isEditing: Bool = true
    @State private var saveButton: Bool = true
    @State private var showToast = false
    
    enum Mood: String, CaseIterable, Identifiable {
        case happy = "Happy"
        case excited = "Excited"
        case hopeful = "Hopeful"
        case neutral = "Neutral"
        case sleepy = "Sleepy"
        case sad = "Sad"
        case angry = "Angry"
        var id: Self { self }
    }
    var MoodColor: Color {
        switch SelectedMood {
        case .happy:
            return Color.green
        case .excited:
            return Color.yellow
        case .hopeful:
            return Color.orange
        case .neutral:
            return Color.gray
        case .sleepy:
            return Color.purple
        case .sad:
            return Color.blue
        case .angry:
            return Color.red
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading){
                
                TextField("Title", text: $Title)
                    .font(.system(.largeTitle, design: .default, weight: .bold))
                    .glassEffect()
                    .cornerRadius(16)
                    .padding(.bottom)
                    .disabled(!isEditing)
                HStack {
                    Text("Description")
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .frame(width: 100, alignment: .topLeading)
                    TextField("Add a description", text: $Description)
                        .glassEffect()
                        .cornerRadius(16)
                        .font(.system(size: 18))
                        .disabled(!isEditing)
                }
                .padding(.bottom)

                HStack() {
                    Text("Mood")
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .frame(width: 100, alignment: .topLeading)
                    Picker("Mood", selection: $SelectedMood) {
                        ForEach(Mood.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .glassEffect()
                    .controlSize(.large)
                    .font(.system(size: 18, weight: .semibold, design: .default))
                    .labelsHidden()
                    .tint(MoodColor)
                    .disabled(!isEditing)

                    Text("Date")
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .padding(.leading, 50)
                    DatePicker("", selection: $NoteDate, displayedComponents: .date)
                        .frame(width: 100,height: 28, alignment: .center)
                        .tint(.clear)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(24)
                        .datePickerStyle(.field)
                        .glassEffect()
                        .controlSize(.large)
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .labelsHidden()
                        .disabled(!isEditing)
                }
            }
            .frame(height: 200)
            ZStack(alignment: .topLeading) {
                if isEditing {
                    TextEditor(text: $MainContent)
                        .font(.system(size: 20))
                        .lineSpacing(5)
                        .cornerRadius(8)
                    if MainContent.isEmpty {
                        Text("Start writing")
                            .font(.system(size: 20))
                            .lineSpacing(5)
                            .padding(.horizontal, 4)
                            .opacity(0.5)
                    }
                } else {
                    Text(.init(MainContent))
                        .font(Font.system(size: 22,))
                        .padding(.top, 50)
                }
            }
            
            HStack {
                if saveButton {
                    Button {
                        saveButton = false
                        showToast = true
                        isEditing = false

                        saveNote(noteTitle: Title, noteDescription: Description, noteMood: SelectedMood.rawValue, noteDate: NoteDate, noteContent: MainContent)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                            withAnimation{
                                showToast = false
                            }
                        }
                        
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 24))
                            .frame(width: 32, height: 32)
                    }
                    .glassEffect()
                    .clipShape(Circle())
                    .tint(Color.green)

                }
                if !isEditing {
                    Button{
                        isEditing = true
                        saveButton = true
                    }label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 20))
                            .frame(width: 32, height: 32)
                    }
                    .glassEffect()
                    .glassEffect()
                    .clipShape(Circle())
                }
                
                if showToast {
                    HStack{
                        Text("Note saved.")
                        Button("Reveal in Finder", action: {
                            openAndSelectFile()
                        })
                        .glassEffect()
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 36)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(32)
                    .transition(.opacity.animation(.easeInOut(duration: 0.5)))
                }
            }
        }
        .padding()
        .navigationTitle(Title.isEmpty ? "Notes" : "Notes - \(Title)")
        Spacer()
    }
}

#Preview {
    ContentView()
}
