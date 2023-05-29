//
//  Word_ViewModel.swift
//  Word_list_App
// MVMV 중 VM 뷰모델 - 리스트를 추가 삭제 관리해주는 뷰모델

import SwiftUI
import RealmSwift

class Word_ViewModel: ObservableObject {
    
    // 모든 뷰에서 관여할 수 있는 리스트
    @Published var Words_Array : [Words]
    
    //뷰 모델을 Init 할때 Realm에서 모든 값을 가져옴
    init(Words_Array: [Words]) {
        self.Words_Array = Array(Words.findAll())
    }
    
    // 단어를 추가하는 함수
    func words_add(kor : String, eng : String, notie : Bool) -> Void{
        guard !kor.isEmpty else { return }
        guard !eng.isEmpty else { return }
        let words = Words()
        words.kor = kor
        words.eng = eng
        words.notie = notie
        self.Words_Array.append(words)
        Words.Words_add(words: words)
    }
    
    
    //단어를 삭제하는 함수 (List에서 삭제시 사용)
    func delete (set: IndexSet){
        for index in set {
            let word = Words_Array[index]
            Words.Words_del(words: word)
            Words_Array.remove(at: index)
        }
    }
    
    //edit,add view에서 삭제 할때 사용함수
    func delete_edit (word: Words){
        Words.Words_del(words: word)
    }
    
    //단어를 수정하는 함수
    func words_edit(old: Words, kor: String, eng:String, notie : Bool) -> Void{
        guard !kor.isEmpty else { return }
        guard !eng.isEmpty else { return }
        Words.Words_edit(old_Words: old, kor: kor, eng: eng, notie : notie)
        
    }
    
//
//    func words_update() -> Void {
//        self.Words_Array = Array(Words.findAll())
//    }
    
    
}
