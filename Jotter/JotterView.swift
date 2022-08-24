//
//  JotterView.swift
//  Jotter
//
//  Created by matterpale on 24.08.2022.
//

import SwiftUI
import WidgetKit

struct JotterView: View {
    @AppStorage("jot", store: UserDefaults(suiteName: "group.jotterapp")) var jotter: String = ""
    @State private var isPresentingConfirm: Bool = false
    
    var body: some View {
        VStack{
            TextEditor(text: $jotter)
                .background(Color.gray.opacity(0.314))
                .padding(5)
            Section{
                HStack{
                    Button(role: .destructive,
                           action: {
                        isPresentingConfirm = true
                    },
                           label: {
                        Text("WIPE")
                            .frame(minWidth: .leastNonzeroMagnitude,
                                   idealWidth: .infinity,
                                   maxWidth: .infinity,
                                   minHeight: 50,
                                   idealHeight: 50,
                                   maxHeight: 50,
                                   alignment: .center)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .cornerRadius(5)
                    })
                    .confirmationDialog("Are you sure?",
                                        isPresented: $isPresentingConfirm) {
                        Button("Wipe all notes", role: .destructive) {
                            jotter.removeAll()
                        }
                    }
                    Button(action: {
                        WidgetCenter.shared.reloadAllTimelines()
                    }, label: {
                        Text("JOT")
                            .frame(minWidth: .leastNonzeroMagnitude,
                                   idealWidth: .infinity,
                                   maxWidth: .infinity,
                                   minHeight: 50,
                                   idealHeight: 50,
                                   maxHeight: 50,
                                   alignment: .center)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .cornerRadius(5)
                    })
                }
            }
        }
    }
}

struct JotterView_Previews: PreviewProvider {
    static var previews: some View {
        JotterView()
            .preferredColorScheme(.dark)
    }
}
