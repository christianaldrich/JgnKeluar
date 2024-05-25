//
//  ContentView.swift
//  JgnKeluar Watch App
//
//  Created by Christian Aldrich Darrien on 23/05/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var watchSession = WatchToiOSConnector.shared
    @State private var title : String = "JgnKeluar"
    @State private var conditionOrder : String = ""
    @State private var condition : String = ""
    @State private var symbolName : String = "apple.logo"
    @State private var symbolColor : Color = .white
    
//    @ObservedObject var watchSessionSharedStatus = WatchToiOSConnector.sharedStatus
    var body: some View {
        //        Text("Testing")
        //        Text(watchSession.status)
        ZStack{
            
            Color.black
            
            VStack(alignment: .center, spacing: 5.0){

                Text(title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                VStack(spacing: 12.0){
                    Image(systemName: symbolName)
                        .foregroundStyle(symbolColor)
                        .font(.largeTitle)
                    VStack(spacing: 3.0){
                        Text(conditionOrder)
                            .fontWeight(.heavy)
                        Text(condition)
                            .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
                            .fontWeight(.light)
                    }
                }
            }
            .padding()
            .onChange(of: watchSession.status){ newStatus in
                updateCondition(status: newStatus)
            }
        }
        .ignoresSafeArea()
    }
        
//                    .padding()
//            .onAppear(perform: {
//                BeaconScannerLogic().validate()
//            })
//        Text("Watch")
//        Text(watchSessionSharedStatus.sharedStatus)
    func updateCondition(status : String){
        if status == "far" || status == "unknown" {
            title = ""
            conditionOrder = "Get back to work!"
            condition = "You're outside the academy."
            symbolName = "x.circle"
            symbolColor = .red
        } else if status == "near" || status == "immediate" {
            title = ""
            conditionOrder = "Great work!"
            condition = "You're inside the academy."
            symbolName = "checkmark.circle"
            symbolColor = .green
        } else {
            title = "JgnKeluar"
            conditionOrder = "Hiya"
            condition = "Unknown status"
            symbolName = "house.fill"
            symbolColor = .white
        }
        
        
    }
}

#Preview {
    ContentView()
}
