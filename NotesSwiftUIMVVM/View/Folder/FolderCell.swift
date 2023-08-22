//
//  FolderCell.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/13.
//

import SwiftUI

struct FolderCell: View {
    @ObservedObject var folderViewModel: FolderViewModel
    var selectedFolder: Folder?
    
    var body: some View {
        NavigationLink {
            NoteListView(folderViewModel: folderViewModel, selectedFolder: selectedFolder)
        } label: {
            HStack {
                Image(systemName: "folder")
                    .foregroundColor(Color.accentColor)
                Text(selectedFolder?.name ?? "すべてのiPhone")
            }
        }
    }
}

struct FolderCell_Previews: PreviewProvider {
    static var previews: some View {
        let folderViewModel = FolderViewModel()
        let folder = Folder(name: "テストメモ1", isEditable: true, notes: testNotes)
        FolderCell(folderViewModel: folderViewModel, selectedFolder: folder)
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
