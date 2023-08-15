//
//  Note.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/14.
//

import SwiftUI

struct Note: Identifiable {
    var id = UUID()
    var title: String
    var content: String
}
