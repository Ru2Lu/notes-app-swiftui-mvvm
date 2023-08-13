//
//  EditFolder.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/13.
//

import SwiftUI

struct EditFolder: View {
    @ObservedObject var folderViewModel: FolderViewModel
    var selectedFolder: Folder
    @Binding var isShow: Bool
    @State var folderNameToUpdate: String
    @State var isDisabledSave = false
    @FocusState private var isTextFieldFocused: Bool

    init(with folderViewModel: FolderViewModel, selectedFolder: Folder, isShow: Binding<Bool>) {
        self.folderViewModel = folderViewModel
        self.selectedFolder = selectedFolder
        self._folderNameToUpdate = State(initialValue: selectedFolder.name)
        self._isShow = isShow
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color(.systemGray4))
                    .frame(width: geo.size.width * 0.70, height: geo.size.width * 0.40, alignment: .center)

                VStack {
                    header
                    textField
                    horizontalDevider(geo: geo)
                    actionButtons
                }
                .frame(width: geo.size.width * 0.70, height: geo.size.width * 0.35)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .background(Color(.gray).opacity(0.5))
        }
        .onAppear {
            isTextFieldFocused = true
        }
    }
    
    private var header: some View {
        Text("フォルダの名前を変更")
            .font(.headline)
            .padding()
    }
    
    private var textField: some View {
        TextField("名前", text: $folderNameToUpdate)
            .frame(width: 200, height: 7)
            .padding()
            .background(Color(.white))
            .cornerRadius(7)
            .focused($isTextFieldFocused)
            .onChange(of: folderNameToUpdate) { newValue in
                isDisabledSave = newValue.isEmpty
            }
    }
    
    private func horizontalDevider(geo: GeometryProxy) -> some View {
        return Color.gray.frame(width: geo.size.width * 0.70, height: CGFloat(1))
    }
    
    private var actionButtons: some View {
        HStack {
            cancelButton
            verticalDevider
            saveButton
        }
    }
    
    private var cancelButton: some View {
        Button("キャンセル") {
            isShow = false
        }
        .frame(maxWidth: .infinity)
    }
    
    private var saveButton: some View {
        Button("保存", action: updateFolder)
            .disabled(isDisabledSave)
            .frame(maxWidth: .infinity)
    }
    
    private var verticalDevider: some View {
        Color.gray.frame(width: 1, height: 30)
    }
    
    private func updateFolder() {
        folderViewModel.updateFolder(selectedFolder, newName: folderNameToUpdate)
        isShow = false
    }
}

struct EditFolder_Previews: PreviewProvider {
    static var previews: some View {
        let folderViewModel = FolderViewModel()
        @State var folder = Folder(name: "テストフォルダ1")
        EditFolder(with: folderViewModel, selectedFolder: folder, isShow: .constant(true))
    }
}
