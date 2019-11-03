//
//  ContentView.swift
//  SignupUI
//
//  Created by Frank Bara on 11/2/19.
//  Copyright © 2019 BaraLabs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showingImagePicker = false
    @State var image: Image? = nil
    
    var body: some View {
        VStack {
            if image == nil {
                Image(systemName: "person.fill")
                .resizable()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
                    .foregroundColor(Color.gray)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                    .padding(.bottom)
            } else {
                image?.resizable()
                .resizable()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
                    .foregroundColor(Color.gray)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                    .padding(.bottom)
            }
            
            Button("Choose Profile Image"){
                self.showingImagePicker.toggle()
            }
        }.sheet(isPresented: $showingImagePicker, content: {
            ImagePicker.shared.view
        }).onReceive(ImagePicker.shared.$image) { image in
            self.image = image
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
