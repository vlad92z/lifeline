//
//  TextBubble.swift
//  Lifeline
//
//  Created by Vlad Z on 28/02/2024.
//

import SwiftUI

struct TextBubble: View {
    
    let text: String
    
    var body: some View {
        ZStack {
            Image(systemName: "arrowtriangle.down.fill")
                .font(.title)
                .offset(x: 0, y: 8)
                .foregroundColor(.pink)
                .font(.system(size: 100))
            Text(text)
                .padding(3)
                .bold()
                .background(Color.pink)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                .listRowSeparator(.hidden)
            
        }
    }
}

#Preview {
    TextBubble(text: "30%")
}
