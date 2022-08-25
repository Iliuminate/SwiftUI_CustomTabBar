//
//  ContentView.swift
//  CustomTabBar
//
//  Created by Carlos Diaz on 24/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(systemName: "folder")
            .font(.system(size: 55, weight: .thin))
            .overlay(Text("❤️"), alignment: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
