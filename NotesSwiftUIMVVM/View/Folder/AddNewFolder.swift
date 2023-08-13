//
//  AddNewFolder.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/13.
//

import SwiftUI

struct AddNewFolder: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var folderViewModel: FolderViewModel
    @State var newFolderName = "新規フォルダ"
    @State private var isShowError: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    
    init(with folderViewModel: FolderViewModel) {
        self.folderViewModel = folderViewModel
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        TextField("", text: $newFolderName)
                            .focused($isTextFieldFocused)
                        if !newFolderName.isEmpty {
                            clearFolderNameButton
                        }
                    }
                }
            }
            .navigationBarTitle("新規フォルダ", displayMode: .inline)
            .navigationBarItems(
                leading: cancelButton,
                trailing: saveButton)
            .alert(isPresented: $isShowError, content: errorAlert)
        }
        .onAppear {
            isTextFieldFocused = true
        }
    }
    
    private var clearFolderNameButton: some View {
        Button(action: {
            newFolderName = ""
        }) {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.secondary)
        }
    }
    
    private var cancelButton: some View {
        Button("キャンセル") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var saveButton: some View {
        Button("保存", action: saveFolder)
    }
    
    private func saveFolder() {
        guard newFolderName != "" else {
            isShowError = true
            return
        }
        folderViewModel.addFolder(name: newFolderName)
        presentationMode.wrappedValue.dismiss()
    }
    
    private func errorAlert() -> Alert {
        Alert(
            title: Text("別の名前を選択してください。"),
            message: Text("フォルダ名は空白にできません。"),
            dismissButton: .default(Text("OK"))
        )
    }
}

struct AddNewFolder_Previews: PreviewProvider {
    static var previews: some View {
        let folderViewModel = FolderViewModel()
        return AddNewFolder(with: folderViewModel)            .environment(\.locale, Locale(identifier: "ja_JP"))

    }
}
