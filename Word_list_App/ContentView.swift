//
//  ContentView.swift
//  Word_list_App
//
//  Created by 김성배 on 2023/05/16.
//

import SwiftUI
import CoreData
import RealmSwift

struct ContentView: View {
    
    @EnvironmentObject var Word_View_Model: Word_ViewModel //뷰간 데이터 공유
    
    @State private var showComposer : Bool = false;
    
    
    var body: some View {
        
        NavigationView{
            List {
                ForEach(Word_View_Model.Words_Array){
                    word in
                    
                    NavigationLink{
                        
                        Word_Detail_View(word)
                        
                    } label: {
                        
                        Word_list_Cell(word)
                        
                    }
                }
                .onDelete(perform: Word_View_Model.delete(set:))
                
            }
            .navigationTitle("메모")
            .toolbar{
                Button{
                    showComposer = true
                }label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showComposer){
                Word_Add_View()
                
            }
        }
        .navigationViewStyle(.stack)
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Word_ViewModel())
    }
}
