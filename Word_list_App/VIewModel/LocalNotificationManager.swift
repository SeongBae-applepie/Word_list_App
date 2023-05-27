//
//  LocalNotificationManager.swift
//  Word_list_App
//
//  Created by 김성배 on 2023/05/26.
//




// local notification 함수
import Foundation
import UserNotifications
import CoreLocation

class LocalNotificationManager {
    
    let kor : String //노티할
    let eng : String
    let date : Date
    let id : UUID
    
    //함수 실행시 받아올 값
    init(kor: String, eng: String, date: Date) {
        self.kor = kor
        self.eng = eng
        self.date = date
        self.id = UUID() // id는 값을 생성해 준다.
    }
    
    
    //퍼미션 결과 얻어오기
    func requestPermission () -> Void {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .alert]) {
            
            granted, error in
            if granted == true && error == nil{
                //퍼미션 얻음
            }
            
        }
    }
    
    
    //
    func schedule () -> Void {
        UNUserNotificationCenter.current().getNotificationSettings(){
            
            settings in
            switch settings.authorizationStatus{
                
            case .notDetermined:
                self.requestPermission() //퍼미션이 허용이아니면 퍼미션 결과 얻기 실행
            case .authorized , .provisional :
                self.scheduleNotifications() // 퍼미션이 허용이면 퍼미션 등록
            default:
                break
            }
            
        }
        
    }
    
    
    // 퍼미션 등록 함수
    func scheduleNotifications() -> Void {

        
        //원하는 시간,분 설정 -> 지금은 1분후로 설정
        let hour: Int = Calendar.current.component(.hour, from: date)
        let min: Int = Calendar.current.component(.minute, from: date)
        
        var date_s = DateComponents()
        
        date_s.hour = hour
        date_s.minute = min + 1
        
        //시간 설정 Notie
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.subtitle = "영어: " + eng
        content.body = "한국어: " + kor
        
        // 바로 Notie
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
      
        //시간설정
        let trigger = UNCalendarNotificationTrigger(dateMatching: date_s, repeats: true)
        
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            guard error == nil else { return }
            print("Scheduling notification with id: \(self.id)")
        }
        
        
    }
}



