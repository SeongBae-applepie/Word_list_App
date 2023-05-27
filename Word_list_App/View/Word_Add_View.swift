//
//  Word_Add_View.swift
//  Word_list_App
//
//  Created by 김성배 on 2023/05/16.
//

import SwiftUI

struct Word_Add_View: View {
    
    @EnvironmentObject var Word_View_Model: Word_ViewModel
    
    // add kor, eng, date 값 설정
    @State private var kor : String = ""
    
    @State private var eng : String = ""
    
    @State private var date : Date = Date();
    
    //화면이 지워질때 dissmiss 변수 설정
    @Environment(\.dismiss) var dissmiss
    
    //localnotification 토글
    @State private var someToggle = false
    
    
    var words = Words()
    
    //notification 설정 함수
    func setNotification(kor: String, eng : String, date : Date) -> Void {
        let manager = LocalNotificationManager(kor: kor, eng: eng, date: date)
        manager.requestPermission()//퍼미션에 대한 여부 묻기
        manager.schedule()//퍼미션여부에 대해서 실행
        
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
                    
                    //영어 HStack
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
                            
                            //파파고 번역
                            eng = try await PapagoNetworkManager.shared.requestTranslate(sourceString: kor, target: "en")
                        }
                        
                        
                    }
                    .padding()
                    .border(Color.black)
                }
                
                //notification 토글
                HStack{
                    Spacer().frame(width: 120)
          
                    Toggle("알림 :",isOn: $someToggle)
                        .onChange(of: someToggle){
                            value in
                            
                            self.setNotification(kor: kor, eng: eng, date: date)
                            
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
                        Word_View_Model.words_add(kor: kor, eng: eng)
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

struct Word_Add_View_Previews: PreviewProvider {
    static var previews: some View {
        Word_Add_View().environmentObject(Word_ViewModel(Words_Array: Array(Words.findAll())))
    }
}
