//
//  ContentView.swift
//  JgnKeluar
//
//  Created by Christian Aldrich Darrien on 23/05/24.
//

import SwiftUI

struct ContentView: View {

//    var backgroundColor = locationScanner().status
    
    @StateObject private var locationScannerCall = locationScanner()
    @State private var scanningText = "Scanning"
    @State private var startingDots = 0
    private let maxDots = 3
    
    
    var body: some View {

        ZStack{
            Color.black
            
            VStack{
                
                Spacer()
                VStack{
                    Text("JgnKeluar")
                        .font(.title)
                        .fontWeight(.bold)
                    Image(systemName: "apple.logo")
                        .font(.largeTitle)
                }
                .foregroundStyle(.white)
                
                Spacer()
                Spacer()
                
                Text(scanningText)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .onAppear(perform: {
                        startScanningAnimation()
                        
                    })
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                HStack{
                    Text("Copyright")
                    Image("whiteCopyRemove")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.white)
                        .frame(width: 15)
                    Text("2024 by Pang")
                }
                .foregroundStyle(.white)
                .padding()
                .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
                
            }
        }
        .ignoresSafeArea()
        .onAppear(perform: {
            locationScanner().startScanning()
        })
        
    }
    
    private func startScanningAnimation() {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                if startingDots < maxDots {
                    startingDots += 1
                } else {
                    startingDots = 0
                }
                scanningText = "Scanning" + String(repeating: ".", count: startingDots)
            }
        }
}


#Preview {
    ContentView()
}
