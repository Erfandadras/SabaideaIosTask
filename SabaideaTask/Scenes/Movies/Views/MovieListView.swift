//
//  MovieListView.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/12/24.
//


import SwiftUI

struct MovieListView: View {
    @FocusState var focused
    
    var body: some View {
        NavigationView {
            VStack {
                
            }// VStack
            .navigationTitle("Home")
            .animation(.linear, value: focused)
        }// navigation view
        .searchable(text: .constant(""), placement: .navigationBarDrawer, prompt: Text("Search"))
        .focused($focused)
        .background(.white)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    MovieListView()
}
