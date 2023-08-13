//
//  SearchBar.swift
//  NotesSwiftUIMVVM
//
//  Created by Ren Usuda on 2023/08/13.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.gray)
            TextField("検索", text: $text)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        @State var searchString = ""
        SearchBar(text: $searchString)
    }
}
