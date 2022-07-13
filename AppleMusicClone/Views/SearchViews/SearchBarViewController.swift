
//  Created by Rookie on 2022/07/05.
//

import SwiftUI

struct SearchBar: UIViewControllerRepresentable {
    
    private let placeholder: String = "아티스트, 노래, 가사 등"
    private let searchScopeTitles: [String] = [SearchScopeBar.appleMusicScopeBarTitle.rawValue, SearchScopeBar.storeScopeBarTitle.rawValue]
    
    @Binding var isSearching: Bool
    @Binding var selectedScope: Int
    @Binding var text: String
    
    //MARK: 부모뷰의 data 변화를 감지하기위해 사용해야하는 클래스
    class Coordinator: NSObject, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
        
        @Binding var selectedScope: Int
        @Binding var text: String
        
        init(text: Binding<String>, selectedScope: Binding<Int>) {
            _text = text
            _selectedScope = selectedScope
        }
        
        func updateSearchResults(for searchController: UISearchController) {
            selectedScope = searchController.searchBar.selectedScopeButtonIndex
            
            if(self.text != searchController.searchBar.text ) {
                self.text = searchController.searchBar.text ?? ""
            }
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, selectedScope: $selectedScope)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SearchBar>) -> UIViewControllerType {
        
        let searchController =  UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = context.coordinator
        searchController.searchBar.scopeButtonTitles = self.searchScopeTitles
        searchController.searchBar.placeholder = placeholder
        
        return SearchBarViewController(searchController: searchController, isSearching: $isSearching)
    }
    
    func updateUIViewController(_ uiViewController: SearchBarViewController, context: UIViewControllerRepresentableContext<SearchBar>) {
        uiViewController.searchController.searchBar.text = text
    }
    
    //MARK: UIkit으로 검색창을 만드는 클래스
    class SearchBarViewController: UIViewController, UISearchControllerDelegate {
        
        var searchController: UISearchController
        @Binding var isSearching: Bool
        
        init(searchController: UISearchController, isSearching: Binding<Bool>) {
            self.searchController = searchController
            _isSearching = isSearching
            super.init(nibName: nil, bundle: nil)
            self.searchController.delegate = self
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func didDismissSearchController(_ searchController: UISearchController) {
            isSearching.toggle()
        }
        
        func didPresentSearchController(_ searchController: UISearchController) {
            isSearching.toggle()
        }

        //MARK: UIkit에서 검색창은 네비게이션바에 위치하는 아이템으로 부모뷰의 네비게이션에 UIkit 서치바를 삽입해주는 코드
        override func didMove(toParent parent: UIViewController?) {
            super.didMove(toParent: parent)
            guard let parent = parent, parent.navigationItem.searchController == nil else  {return}
            parent.navigationItem.searchController = searchController
        }
    }
}

enum SearchCategory: Int {
    case appleMusic = 0
    case store = 1
}

enum SearchScopeBar: String {
    case appleMusicScopeBarTitle = "Apple Music"
    case storeScopeBarTitle = "보관함"
}
