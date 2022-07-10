//
//  ArtistRow.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/07.
//

import SwiftUI

struct ArtistRow: View {
    
    @ObservedObject var searchViewModel: SearchViewModel
    
    var body: some View {
        
        LazyVStack {
            ForEach(searchViewModel.artists.indices, id: \.self) { index in
                HStack {
                    AsyncImage(url:
                                searchViewModel.artists[index].imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 5)
                    }
                    .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(searchViewModel.artists[index].inform)
                        Text(searchViewModel.artists[index].type ?? "")
                            .foregroundColor(.yaleGray)
                    }
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.yaleGray)
                }
            }
        }
    }
}

struct ArtistRow_Previews: PreviewProvider {
    static var previews: some View {
        ArtistRow(searchViewModel: SearchViewModel())
    }
}
