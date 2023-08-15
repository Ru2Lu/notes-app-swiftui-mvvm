//
//  Folder.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/13.
//

import SwiftUI

struct Folder: Identifiable {
    var id = UUID()
    var name: String
    var isEditable: Bool = true
    var notes: [Note] = []
}
