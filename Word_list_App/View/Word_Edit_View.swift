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
    
    @State private var notie : Bool = false
    
    @State private var notie_c : Bool = false
    
    @Environment(\.dismiss) var dissmiss
    
    var words : Words
    
    func setNotification(kor: String, eng : String, date : Date) -> Void {
        let manager = LocalNotificationManager(kor: kor, eng: eng, date: date)
        manager.requestPermission()//퍼미션에 대한 여부 묻기
        manager.schedule()//퍼미션여부에 대해서 실행
        
    }
    
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
                
                //notification 토글
                HStack{
                    
                    Spacer().frame(width: 120)
                    
                    Toggle("알림 :",isOn: $notie)
                        .onAppear(){
                            notie = words.notie
                            notie_c = notie
                        }

                    Spacer().frame(width: 120)
                    
                    
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
                        
                        
                        if(notie_c == false && notie == true){ // notie 추가
                            
                            self.setNotification(kor: kor, eng: eng, date: Date())
                            Word_View_Model.words_edit(old: words, kor: kor, eng: eng, notie: notie)
                            
                            Word_View_Model.Words_Array = Array(Words.findAll())
                            dissmiss()
                            
                        
                        }else if(notie_c == true && notie == false){ //notie 삭제
                            self.
                            
                            
                        }
                        
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

