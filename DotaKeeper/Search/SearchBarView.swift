//
//  TopBar.swift
//  DotaKeeper
//
//  Created by Spencer Lohrmann on 9/18/22.
//

import SwiftUI

struct SearchBarView<E: PickerEnum>: View where E.RawValue == String {

    @Binding var pickerState: E
    @State private var searchText: String = ""

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.bottom, 5)
            FilterBar(pickerState: $pickerState)
        }
    }
}

struct FilterBar<E: PickerEnum>: View where E.RawValue == String {

    @Binding var pickerState: E
    @State private var showingFilter: Bool = false

    var body: some View {
        VStack {
            HStack {
                Picker("", selection: $pickerState) {
                    Group {
                        ForEach(Array(E.allCases), id: \.self) { variable in
                            Text("\(variable.rawValue)")
                        }
                    }
                }
                .pickerStyle(.segmented)
                FilterButton {
                    showingFilter.toggle()
                }
                .sheet(isPresented: $showingFilter) {
                    FilterView {
                        pickerState.body
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing: Bool = false

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $text)
                    .onSubmit {
                        // Search for players with name
                    }
                    .onTapGesture {
                        self.isEditing = true
                    }
            }
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(6)

            if isEditing {
                Button {
                    self.isEditing = false
                    self.text = ""
                } label: {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default, value: isEditing)
            }
        }
        .padding(.horizontal)
    }
}

struct FilterButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "line.3.horizontal.decrease.circle")
        }
    }
}

struct TopBar_Previews: PreviewProvider {
    @State static var pickerState: GlossaryPickerState = GlossaryPickerState.heroes

    static var previews: some View {
        VStack {
            SearchBarView<GlossaryPickerState>(pickerState: $pickerState)
            Spacer()
        }
    }
}
