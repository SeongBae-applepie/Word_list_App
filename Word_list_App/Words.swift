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


//model
class Words : Object , Identifiable{
    @Persisted var kor : String = "" //한국어
    @Persisted var eng : String = "" // 영어
    @Persisted var id: UUID = UUID() // id 값 (고유 값을 분리하기 위해)
    @Persisted var notie : Bool //Notification 토글
    @Persisted var date : Date //설정 날짜
}

extension Words {
    
    //Realm 함수 생성
    private static var realm = try! Realm()
    
    
    //모든 값 가져오기
    static func findAll() -> Results<Words>{
        
        realm.objects(Words.self)
    }
    
    
    //값 삭제
    static func Words_del (words : Words){
        try! realm.write {
            realm.delete(words)
        }
    }
    
    //값 생성
    static func Words_add (words : Words){
        try! realm.write {
            realm.add(words)
        }
    }
    
    //값 변경
    static func Words_edit ( old_Words : Words , kor : String, eng : String, notie:Bool){
        try! realm.write {
            old_Words.kor = kor
            old_Words.eng = eng
            old_Words.notie = notie
        }
    }
    
    //notie 값 변경 (구현 전)
    static func Words_edit_notie ( old_Words : Words , kor : String, eng : String, notie : Bool, date :Date){
        try! realm.write {
            old_Words.kor = kor
            old_Words.eng = eng
            old_Words.notie = notie
            old_Words.date = date
        }
    }
    
    
}
