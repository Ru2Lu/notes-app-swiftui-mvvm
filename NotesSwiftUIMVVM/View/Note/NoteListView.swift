//
//  NoteListView.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/22.
//

import SwiftUI

struct NoteListView: View {
    @ObservedObject var folderViewModel: FolderViewModel
    var selectedFolder: Folder?
    @State var searchString = ""
    @State var allNotes: [Note] = []
    
    var body: some View {
        // TODO: NavigationViewが入れ子になっていることが原因で上部にスペースができる問題を修正する
        NavigationView {
            List {
                SearchBar(text: $searchString)
                noteSection
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(selectedFolder?.name ?? "すべてのiPhone")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    notesCountText
                    Spacer()
                    addNoteButton
                }
            }
            .onAppear {
                folderViewModel.selectFolder(selectedFolder)
                allNotes = folderViewModel.noteViewModel.notes
            }
        }
    }
    
    private var noteSection: some View {
        Section(header:
            Text("過去7日間")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)) {
            ForEach(allNotes) { note in
                NoteCell(title: note.title, content: note.content, folderName: selectedFolder?.name ?? "すべてのiPhone(要修正)")
            }
        }
    }
    
    private var notesCountText: some View {
        Text("\(allNotes.count)件のメモ")
    }
    
    private var addNoteButton: some View {
        NavigationLink {
            AddNoteView(folderViewModel: folderViewModel)
        } label: {
            Label("", systemImage: "square.and.pencil")
                .foregroundColor(Color.accentColor)
        }
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        let folderViewModel = FolderViewModel()
        NoteListView(folderViewModel: folderViewModel, selectedFolder: nil)
    }
}
