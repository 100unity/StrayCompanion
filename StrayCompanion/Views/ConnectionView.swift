//
//  ConnectionView.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 01/03/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

import SwiftUI

struct ConnectionView: View {
    @EnvironmentObject var model: CompanionModel
    
    @State private var host = ""
    @State private var port = ""
    @State private var invalidPort = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Stray Companion")
                .font(.title)
                .fontWeight(.bold)
            
            HStack(spacing: 15) {
                VStack {
                    Text("Host")
                        .frame(maxHeight: .infinity)
                        .padding(.bottom, 16)
                    Text("Port")
                        .frame(maxHeight: .infinity)
                        .padding(.bottom, 8)
                }
                VStack {
                    TextField("e.g. 127.0.0.1", text: self.$host)
                    Divider()
                    TextField("e.g. 7999", text: self.$port)
                        .alert(isPresented: $invalidPort) {
                            Alert(title: Text("Invalid port specified"), message: Text("Please enter a number between 0 and 65535"), dismissButton: .default(Text("OK")) { self.invalidPort = false })
                        }
                    Divider()
                }
            }.fixedSize(horizontal: false, vertical: true)
            
            Button(action: self.connect) {
                Text("Connect")
                Image(systemName: "arrow.right")
            }
        }.padding()
    }
}

extension ConnectionView {
    func connect() {
        guard let port = UInt16(port) else {
            invalidPort = true
            return
        }
        withAnimation {
            model.connect(host: host, port: port)
        }
    }
}

struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView()
    }
}
