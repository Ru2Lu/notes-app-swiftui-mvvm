//
//  NotesSwiftUIMVVMApp.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/12.
//

import SwiftUI

@main
struct NotesSwiftUIMVVMApp: App {
    @StateObject private var folderViewModel = FolderViewModel()
    
    var body: some Scene {
        WindowGroup {
            FolderView(folderViewModel: folderViewModel)
        }
    }
}
