//
//  FilterView.swift
//  DotaKeeper
//
//  Created by Spencer Lohrmann on 9/18/22.
//

import SwiftUI

struct FilterView<Content>: View where Content: View {

    @Environment(\.dismiss) var dismiss

    let content: Content

    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            HStack {
                Button("Apply") {
                    dismiss()
                }
                .padding()
                Spacer()
                Button("Press to dismiss") {
                    dismiss()
                }
                .padding()
            }
            content
        }
    }
}

struct HeroFilter: View {
    var body: some View {
        Text("Hero Filter")
    }
}

struct MatchFilter: View {
    var body: some View {
        Text("Match Filter")
    }
}

struct PlayerFilter: View {
    var body: some View {
        Text("Player Filter")
    }
}

struct ItemFilter: View {
    var body: some View {
        Text("Item Filter")
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView<HeroFilter> {
            HeroFilter()
        }
    }
}
