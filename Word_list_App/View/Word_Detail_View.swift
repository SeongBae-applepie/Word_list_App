//
//  Word_Detail_View.swift
//  Word_list_App
//
//  Created by 김성배 on 2023/05/16.
//

import SwiftUI

struct Word_Detail_View: View {
    
    //리스트 값
    @EnvironmentObject var Word_View_Model: Word_ViewModel
    
    //에딧버튼 부울값 부모 함수와 소통
    @State private var shoewComposer : Bool = false
    
    //삭제 버튼 부울값
    @State private var showDeleteAlert : Bool = false

    // dismiss 화면 나가기 함수
    @Environment(\.dismiss) var dismiss
    
    // 단어객체
    @StateObject var words : Words

    
   
    
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
                
                //realm+swiftui 구조로 불가능으로 판단. -> coredata를 사용으로 바꿀예정
                
                //delete
//                ToolbarItemGroup(placement: .bottomBar){
//
//                    Button{
//
//                        showDeleteAlert = true
//
//                    }label: {
//                        Image(systemName: "trash")
//                    }.alert("삭제확인 ?" , isPresented: $showDeleteAlert){
//                        Button(role: .destructive){
//                            dismiss()
//                            self.Word_View_Model.Words_Array.removeAll()
//                            Word_View_Model.delete_edit(word: words)
//                            self.Word_View_Model.Words_Array = Array(Words.findAll())
//                        }label: {
//                            Text("삭제")
//                        }
//
//                    } message: {
//                        Text("삭제 할까요?")
//                    }
//
//                }
                
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
        Word_Detail_View(words:Words()).environmentObject(Word_ViewModel(Words_Array: Array(Words.findAll())))
    }
}
