//
//  FolderViewModel.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/13.
//

import SwiftUI

class FolderViewModel: ObservableObject {
    @Published var folders: [Folder] = []
    var noteViewModel = NoteViewModel()
    
    init() {
        loadFolders()
    }
    
    func loadFolders() {
        folders = testFolders
    }
    
    func addFolder(name: String) {
        let newFolder = Folder(name: name)
        folders.append(newFolder)
    }
    
    func updateFolder(_ folder: Folder, newName: String) {
        if let index = folders.firstIndex(where: { $0.id == folder.id }) {
            folders[index].name = newName
        }
    }
    
    func deleteFolder(_ folder: Folder) {
        if let index = folders.firstIndex(where: { $0.id == folder.id }) {
            folders.remove(at: index)
        }
    }
    
    func selecteFolder(_ folder: Folder) {
        noteViewModel.notes = folder.notes
    }
}

var testFolders = [
    Folder(name: "メモ", isEditable: false, notes: testNotes),
    Folder(name: "テストフォルダ1"),
    Folder(name: "テストフォルダ2")
]

var testNotes = [
    Note(title: "タイトル1", content: "コンテント1"),
    Note(title: "タイトル2", content: "コンテント2"),
    Note(title: "タイトル3", content: "コンテント3")
]
