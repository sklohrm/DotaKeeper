//
//  SavedView.swift
//  DotaKeeper
//
//  Created by Spencer Lohrmann on 9/18/22.
//

import SwiftUI

struct SavedView: View {
    @State private var searchText: String = ""
    @State private var pickerState = SearchPickerState.heroes

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TopBarView(pickerState: $pickerState)

    //                ScrollView {
                        ForEach(1...100, id: \.self) { index in
                            Text("Saved \(pickerState.rawValue) \(index)")
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
    //                }
                }
                .navigationTitle("Search")
                .toolbar {
                    Button {
                        // Testing
                    } label: {
                        Label("Sort", systemImage: "questionmark.square.dashed")
                    }

            }
            }
        }
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
