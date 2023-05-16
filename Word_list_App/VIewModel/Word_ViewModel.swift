//
//  Word_ViewModel.swift
//  Word_list_App
//
//  Created by 김성배 on 2023/05/16.
//

import SwiftUI

class Word_ViewModel: ObservableObject {
    
    @Published var Words_Array : [Words] = Array(Words.findAll())
    
    func words_add(kor : String, eng : String) -> Void{
        guard !kor.isEmpty else { return }
        guard !eng.isEmpty else { return }
        let words = Words()
        words.kor = kor
        words.eng = eng
        self.Words_Array.append(words)
        Words.Words_add(words: words)
    }
    
    func words_delete ( words : Words){
        
        Words.Words_del(words: words)
        self.Words_Array = Array(Words.findAll())
        
    }
    
    func delete (set: IndexSet){
        for index in set {
            let word = Words_Array[index]
            Words.Words_del(words: word)
            Words_Array.remove(at: index)
        }
    }
    
    
    
    func words_edit(old: Words, kor: String, eng:String) -> Void{
        guard !kor.isEmpty else { return }
        guard !eng.isEmpty else { return }
        Words.Words_edit(old_Words: old, kor: kor, eng: eng)
        
    }
    
    
//    func words_update(){
//        self.Words_Array = Array(Words.findAll())
//    }
//    
//    
    
    
}
