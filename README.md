# Notes App

## Table of contents 📚
- [Notes App](#notes-app)
  - [Table of contents 📚](#table-of-contents-)
  - [Overview 🌎](#overview-)
  - [Files 📑](#files-)
  - [Mood section 😶](#mood-section-)
  - [Main content ✍️](#main-content-️)
  - [Work in progress ⏳](#work-in-progress-)
  - [Next steps 👣](#next-steps-)

## Overview 🌎
*This was my first project using Swift*

This app allows users to create their own notes and save them locally. [Notes App](#notes-app) includes fields such as title, description, mood, date and the main content.

<img width="1161" height="573" alt="App - Overview" src="https://github.com/user-attachments/assets/7c22370b-c9ed-44f9-acdc-c8d21fca9c15" />

## Files 📑
- [ContentView.swift](/notes/ContentView.swift) - UX & UI.
- [json.swift](/notes/json.swift) - Converts all the entries into a JSON format and saves to the file system.
- [notesApp.swift](/notes/notesApp.swift) - Runs the app.

## [Mood section 😶](/notes/ContentView.swift#L65-L79)
This section uses a Segmented Picker, which makes it easy to switch between and view.
The picker also changes its colors based on the selected mood.

![Mood - Gif](https://github.com/user-attachments/assets/dc565253-d6a0-42b0-a5d9-c530f2667501)

*By default, the selected mood is **happy** — because this should be the most common mood 😉.*

## [Main content ✍️](/notes/ContentView.swift#L99-L116)

The main content (TextEditor) supports some markdown symbols, using **bold** or *italic*, using `**` for bold, and `*` for italic. Add these symbols at the beginning and end of the text you want to emphasize.
Although you can't see the markdown when editing your note, when you save, the markdown will render correctly when you save.

![bold and italic](https://github.com/user-attachments/assets/6902682e-bfbf-4fbd-ba53-4af8267a0239)

*I plan to implement bold and italic buttons in the future🙏🏽.*

## Work in progress ⏳
- Implementing [listJsonFiles()](/notes/json.swift#L52-L62) and [ReadJsonFile()](/notes/json.swift#L64-L80) — to show all saved notes.

## Next steps 👣
- Add a **+** button to allow users create a new note.
- Add **bold** and **italic** buttons.