//
//  Word_Realm_Model.swift
//  Word_list_App
//
//  Created by 김성배 on 2023/05/16.
//
// https://github.com/realm/realm-swift.git - package add url

// Realm을 이용해 저장기능 구현

import Foundation
import RealmSwift

class Words : Object , Identifiable{
    @Persisted var kor : String = ""
    @Persisted var eng : String = ""
    @Persisted var id: UUID = UUID()
}

extension Words {
    
    private static var realm = try! Realm()
    
    static func findAll() -> Results<Words>{
        
        realm.objects(Words.self)
    }
    
    static func Words_del (words : Words){
        try! realm.write {
            realm.delete(words)
        }
    }
    
    static func Words_add (words : Words){
        try! realm.write {
            realm.add(words)
        }
    }
    
    static func Words_edit ( old_Words : Words , kor : String, eng : String){
        try! realm.write {
            old_Words.kor = kor
            old_Words.eng = eng
        }
    }
    
    
}
