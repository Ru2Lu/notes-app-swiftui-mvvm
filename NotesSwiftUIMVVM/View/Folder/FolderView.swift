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
    @State var isShowAddFolderSheet = false
    @State var isShowEditFolderPopover = false
    @State var folderNameToUpdate = ""
    @State var selectedFolder: Folder?
    
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
            .sheet(isPresented: $isShowAddFolderSheet) {
                AddNewFolder(with: folderViewModel)}
        
            if isShowEditFolderPopover {
                EditFolder(with: folderViewModel, selectedFolder: selectedFolder!, isShow: $isShowEditFolderPopover)
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
                FolderCell(name: "すべてのiPhone")
            }
            ForEach(folderViewModel.folders) { folder in
                if !folder.isEditable {
                    FolderCell(name: folder.name)
                } else {
                    FolderCell(name: folder.name)
                        .contextMenu {
                            Button(action: {
                                selectedFolder = folder
                                isShowEditFolderPopover = true
                            }) {
                                Text("名称変更")
                                Image(systemName: "pencil")
                            }
                            Button(role: .destructive, action: {
                                folderViewModel.deleteFolder(folder)
                            }) {
                                Text("削除")
                                Image(systemName: "trash")
                            }
                        }
                }
            }
        }
        .textCase(nil)
    }
    
    private var addFolderButton: some View {
        Image(systemName: "folder.badge.plus")
            .foregroundColor(Color.accentColor)
            .onTapGesture {
                isShowAddFolderSheet.toggle()
            }
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

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        let folderViewModel = FolderViewModel()
        return FolderView(folderViewModel: folderViewModel)
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
