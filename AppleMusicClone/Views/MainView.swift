//
//  MainView.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            
            //TODO: 각 뷰 넣기
            Text("1")
                .tabItem {
                    Image(systemName: "play.circle.fill")
                    Text("지금 듣기")
                }
            
            Text("2")
                .tabItem {
                    Image(systemName: "dot.radiowaves.left.and.right")
                    Text("라디오")
                }

            Text("3")
                .tabItem {
                    Image(systemName: "folder")
                    Text("보관함")
                }

            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
