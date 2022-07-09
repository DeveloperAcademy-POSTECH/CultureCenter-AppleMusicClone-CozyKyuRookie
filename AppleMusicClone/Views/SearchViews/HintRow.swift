//
//  HintRow.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/07.
//

import SwiftUI

struct HintRow: View {
    
    @StateObject var searchVM: SearchViewModel
    
    var body: some View {
        
        LazyVStack {
            ForEach(searchVM.hints.indices, id: \.self) { index in
                VStack(alignment: .leading, spacing: 15) {
                    Divider().opacity(index == 0 ? 1 : 0)
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text(searchVM.hints[index].inform)
                    }
                    Divider()
                }
            }
        }
        
    }
}


