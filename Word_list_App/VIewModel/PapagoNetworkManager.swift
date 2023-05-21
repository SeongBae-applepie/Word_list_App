//
//  PapagoNetworkManager.swift
//  Word_list_App
//
//  Created by 김성배 on 2023/05/16.
//

// https://velog.io/@gkals4417/CanWeTalk-Network1 - 차고 사이트

// 파파고 naver api 사용 swift 파일

import Foundation

final class PapagoNetworkManager: ObservableObject {
    
    
    static let shared: PapagoNetworkManager = PapagoNetworkManager()
    
    init() { }
    
    let baseURL: String = "https://openapi.naver.com/v1/papago/n2mt"
    
    func requestTranslate(sourceString: String, target: String) async throws -> String {
        
        var E_sourceString = sourceString
        
        let clientID = "DB8mQIh8dsji2i0ttKeQ"
        let clinetSecret = "Ohs6WGrJC6"
        
        if (E_sourceString == nil || E_sourceString == ""){
            E_sourceString = "..."
        }
        
        let stringWithParameters = "source=ko&target=\(target)&text=\(E_sourceString)"
        
        let data = stringWithParameters.data(using: .utf8)!
        
        guard let url = URL(string: baseURL) else { return "" }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(clientID,forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(clinetSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        request.httpBody = data
        
        let (responseData, _ ) = try await URLSession.shared.upload(for: request, from: data)
        let response: TranslateResponse = decodeData(responseData)
        let translatedString = response.message.result.translatedText
        
        return translatedString
    }
    
    
    
    //    데이터 읽어오기
    func decodeData <T: Decodable> (_ data: Data) -> T {
        do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch (let error) {
                
                
                print(error)
                preconditionFailure("Fail to decode Data")
            }
    }
    

    // MARK: - 데이터를 받아오는 구조
    
    struct Message: Decodable {
        let type, service, version: String
        let result: Result

        enum CodingKeys: String, CodingKey {
            case type = "@type"
            case service = "@service"
            case version = "@version"
            case result
        }
    }

    struct Result: Decodable {
        let translatedText: String
    }

    struct TranslateResponse: Decodable {
        let message: Message
    }


}

