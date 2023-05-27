//
//  Word_list_AppApp.swift
//  Word_list_App
//
//  Created by 김성배 on 2023/05/16.
//

import SwiftUI

@main
struct Word_list_AppApp: App {
    

    @StateObject var Word_View_Model = Word_ViewModel(Words_Array: Array(Words.findAll()))
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Word_View_Model)
        }
    }
}
