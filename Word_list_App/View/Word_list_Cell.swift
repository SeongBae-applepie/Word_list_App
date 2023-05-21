//
//  Word_list_Cell.swift
//  Word_list_App
//
//  Created by 김성배 on 2023/05/16.
//

// list cell 디자인

import SwiftUI

struct Word_list_Cell: View {
    
    var words : Words
    
    init(_ words : Words) {
        self.words = words
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(words.kor)
                .bold().font(.body).lineLimit(1)

            Text(words.eng)
                .foregroundColor(Color.gray)
                .font(.caption)
            
        }
    }
}

struct Word_list_Cell_Previews: PreviewProvider {
    static var previews: some View {
        Word_list_Cell(Words())
    }
}
