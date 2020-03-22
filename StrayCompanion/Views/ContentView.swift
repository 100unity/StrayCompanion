//
//  ContentView.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 28/02/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: CompanionModel
    
    @State private var host = ""
    @State private var port = ""
    
    var body: some View {
        ZStack() {
            if model.connected {
                CompanionView()
                    .transition(.move(edge: .trailing))
                    .zIndex(2)
            } else {
                ConnectionView()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
