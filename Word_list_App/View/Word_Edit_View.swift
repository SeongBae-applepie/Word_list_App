//
//  Word_Edit_View.swift
//  Word_list_App
//
//  Created by 김성배 on 2023/05/16.
//

import SwiftUI

struct Word_Edit_View: View {
    
    @EnvironmentObject var Word_View_Model: Word_ViewModel
    
    @State private var kor : String = ""
    
    @State private var eng : String = ""
    
    @Environment(\.dismiss) var dissmiss
    
    var words : Words
    
    init(_ words: Words) {
        self.words = words
    }
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                HStack{
                    //한국어 HStack
                    HStack(){
                        Text("한국어 : ")
                        
                        TextEditor(text:  $kor)
                            .onAppear(){
                                kor = words.kor
                            }
                            .frame(height:35)
                            .border(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 20))
                    }
                    .padding()
                    .frame(height: 100)
                    
                    //일본어 HStack
                    HStack{
                        Text("영어 : ")
                        TextEditor(text:  $eng)
                            .onAppear(){
                                eng = words.eng
                            }
                            .frame(height:35)
                            .border(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(.system(.body))
                    }
                    .padding()
                    .frame(height: 100)
                }
                //번역 버튼
                HStack(alignment: .center){
                    Button("번역"){
                        Task{
                            
                            //파파고번역
                            eng = try await PapagoNetworkManager.shared.requestTranslate(sourceString: kor, target: "en")
                            
                        }

                        
                    }
                    .padding()
                    .border(Color.black)
                }
                Spacer()
            }
            .navigationTitle("New Word")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                
                //취소 버튼
                ToolbarItemGroup(placement: .navigationBarLeading)
                {
                    Button{
                        dissmiss()
                    } label: {
                        Text("취소");
                    }
                    
                }
                
                //저장 버튼
                ToolbarItemGroup(placement: .navigationBarTrailing)
                {
                    Button{
                        
                        Word_View_Model.words_edit(old: words, kor: kor, eng: eng)
                        Word_View_Model.Words_Array = Array(Words.findAll())
                        dissmiss()
                        
                    } label: {
                        Text("저장");
                    }
                }
            }
            Spacer()
        }
     
    }
}

struct Word_Edit_View_Previews: PreviewProvider {
    static var previews: some View {
        Word_Edit_View(Words()).environmentObject(Word_ViewModel(Words_Array: Array(Words.findAll())))
    }
}

