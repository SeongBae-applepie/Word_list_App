//
//  Word_Detail_View.swift
//  Word_list_App
//
//  Created by 김성배 on 2023/05/16.
//

import SwiftUI

struct Word_Detail_View: View {
    
    @EnvironmentObject var Word_View_Model: Word_ViewModel
    
    @State private var shoewComposer : Bool = false
    
    @State private var showDeleteAlert : Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var words : Words
    
    init(_ words: Words){
        self.words = words
        
    }
    
    var body: some View {
        VStack{
            ScrollView{
                VStack(alignment: .leading){
                    
                    HStack {
                        
                        VStack (alignment: .leading){
                            Text(words.kor)
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                                .bold()
                                .font(.system(size: 30))
                            
                            
                            Text(words.eng)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                .font(.footnote)
                            
                        }
                        
                        Spacer()
                    }
                    
                }
                
            }
            .padding()
            .navigationTitle("메모 보기")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar{
                
                //delete
                ToolbarItemGroup(placement: .bottomBar){
                    
                    Button{
                        
                        showDeleteAlert = true
                        
                    }label: {
                        Image(systemName: "trash")
                    }.alert("삭제확인 ?" , isPresented: $showDeleteAlert){
                        Button(role: .destructive){
                            Word_View_Model.words_delete(words: words)
                            dismiss()
                        }label: {
                            Text("삭제")
                        }
                        
                    } message: {
                        Text("삭제 할까요?")
                    }
                    
                }
                
                //edit
                ToolbarItemGroup(placement: .bottomBar){
                    Button {
                        shoewComposer = true
                    }label: {
                        Image(systemName: "square.and.pencil")
                    }
                    
                }
                
                
                
            }
            .sheet(isPresented:  $shoewComposer){
                Word_Edit_View(words)
            }
            
        }
    }
}

struct Word_Detail_View_Previews: PreviewProvider {
    static var previews: some View {
        Word_Detail_View(Words()).environmentObject(Word_ViewModel())
    }
}
