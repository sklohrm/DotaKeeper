//
//  ProfileView.swift
//  DotaKeeper
//
//  Created by Spencer Lohrmann on 9/18/22.
//

import SwiftUI

// Show logo on first launch.
// If user has logged in, store steam image in UserDefaults.

struct ProfileView: View {
    @State private var username: String = ""
    private var testBool: Bool = false

    var body: some View {
        ScrollView {
            LazyVStack {
                if testBool {
                    LogoView()
                } else {
                    UserStatsView()
                }
                TextField("Enter Steam ID", text: $username)
                ForEach(1...100, id: \.self) { index in
                    Text("Match \(index)")
                        .padding()
                }

            }
        }
    }
}

struct LogoView: View {
    var body: some View {
        Image("Dota-2-Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.top)
            .padding(.horizontal)
    }
}

struct UserStatsView: View {
    var body: some View {
        VStack {
            LogoView()
            Text("Player Name")
            HStack {
                Text("Player MMR")
                Text("Player Win Loss")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
