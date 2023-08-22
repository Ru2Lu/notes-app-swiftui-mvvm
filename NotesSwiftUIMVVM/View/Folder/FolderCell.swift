//
//  FolderCell.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/13.
//

import SwiftUI

struct FolderCell: View {
    var name: String
    
    var body: some View {
        NavigationLink {
            Text("NoteListView")
        } label: {
            HStack {
                Image(systemName: "folder")
                    .foregroundColor(Color.accentColor)
                Text(name)
            }
        }
    }
}

struct FolderCell_Previews: PreviewProvider {
    static var previews: some View {
        FolderCell(name: "テスト1")
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
