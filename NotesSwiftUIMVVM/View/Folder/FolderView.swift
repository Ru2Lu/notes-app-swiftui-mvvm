//
//  FolderView.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/12.
//

import SwiftUI

struct FolderView: View {
    @ObservedObject var folderViewModel: FolderViewModel
    @State var searchString = ""
    @State var isShowPopover = false
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    SearchBar(text: $searchString)
                    folderSection
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("フォルダ")
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        addFolderButton
                        addNoteButton
                    }
                }
            }
            .sheet(isPresented: $isShowPopover) {
                AddNewFolder(with: folderViewModel)
            }
        }
    }
    
    private var folderSection: some View {
        Section(header:
            Text("iPhone")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)) {
            if folderViewModel.folders.count > 0 {
                FolderCell(name: "全てのiPhone")
            }
            FolderCell(name: "メモ")
            ForEach(folderViewModel.folders) { folder in
                FolderCell(name: folder.name)
            }
            .onDelete(perform: folderViewModel.deleteFolder)
        }
        .textCase(nil)
    }
    
    private var addFolderButton: some View {
        Image(systemName: "folder.badge.plus")
            .onTapGesture {
                isShowPopover.toggle()
            }
    }
    
    private var addNoteButton: some View {
        Image(systemName: "square.and.pencil")
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        let folderViewModel = FolderViewModel()
        return FolderView(folderViewModel: folderViewModel)
    }
}
