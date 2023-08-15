//
//  AddNoteView.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/14.
//

import SwiftUI

struct AddNoteView: View {
    @ObservedObject var folderViewModel: FolderViewModel
    @State private var note = Note(title: "", content: "")
    @State private var text = ""
    @FocusState private var isFocusedTextEditor: Bool
    
    init(folderViewModel: FolderViewModel) {
        self.folderViewModel = folderViewModel
        if let uneditableFolder = folderViewModel.folders.first(where: { $0.isEditable == false }) {
            folderViewModel.selecteFolder(uneditableFolder)
        }
    }
    
    var body: some View {
        TextEditor(text: $text)
            .padding(.horizontal)
            .focused($isFocusedTextEditor)
            .onDisappear(perform: addNote)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("完了") {
                    addNote()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isFocusedTextEditor = true
        }
    }
    
    private func addNote() {
        if text == "" { return }
        
        var title = ""
        var content = ""
        
        if let index = text.firstIndex(of: "\n") {
            title = String(text[...index])
            content = String(text[text.index(after: index)...])
        } else {
            title = text
        }
        
        folderViewModel.noteViewModel.addNote(title: title, content: content)
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        let folderViewModel = FolderViewModel()
        AddNoteView(folderViewModel: folderViewModel)
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
