//
//  NoteViewModel.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/14.
//

import SwiftUI

class NoteViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        notes.append(newNote)
    }
}
