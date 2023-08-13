//
//  FolderViewModel.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/13.
//

import SwiftUI

class FolderViewModel: ObservableObject {
    @Published var folders: [Folder] = []
    
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
    
    func deleteFolder(at offsets: IndexSet) {
        folders.remove(atOffsets: offsets)
    }
}

var testFolders = [
    Folder(name: "テストフォルダ1"),
    Folder(name: "テストフォルダ2")
]
