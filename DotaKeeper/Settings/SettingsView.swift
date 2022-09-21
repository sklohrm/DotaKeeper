//
//  SettingsView.swift
//  DotaKeeper
//
//  Created by Spencer Lohrmann on 9/18/22.
//

import SwiftUI

struct SettingsView: View {
    @State private var testSetting: Bool = true

    var body: some View {
        Form {
            Section {
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
            } header: {
                Text("Profile")
            }
            Section {
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
            } header: {
                Text("Appearance")
            }
            Section {
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
                Toggle(isOn: $testSetting) {
                    Text("Setting")
                }
            } header: {
                Text("General")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
