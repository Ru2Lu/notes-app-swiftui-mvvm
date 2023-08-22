//
//  NoteCell.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/22.
//

import SwiftUI

struct NoteCell: View {
    var title: String
    var content: String
    var folderName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
            Text(content)
                .foregroundColor(.gray)
            HStack {
                Image(systemName: "folder")
                    .foregroundColor(.gray)
                Text(folderName)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct NoteCell_Previews: PreviewProvider {
    static var previews: some View {
        NoteCell(title: "タイトル1", content: "コンテンツ1", folderName: "フォルダ1")
    }
}
