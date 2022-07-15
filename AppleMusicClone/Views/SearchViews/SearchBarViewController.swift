//  Created by Rookie on 2022/07/05.
//

import SwiftUI

struct SearchBar: UIViewControllerRepresentable {
    private let placeholder: String = "아티스트, 노래, 가사 등"
    private let searchScopeTitles: [String] = [SearchCategory.appleMusic.rawValue, SearchCategory.store.rawValue]

    @Binding var isSearching: Bool
    @Binding var selectedScope: SearchCategory
    @Binding var text: String

    // MARK: 부모뷰의 data 변화를 감지하기위해 사용해야하는 클래스

    class Coordinator: NSObject, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
        @Binding var selectedScope: SearchCategory
        @Binding var text: String

        init(text: Binding<String>, selectedScope: Binding<SearchCategory>) {
            _text = text
            _selectedScope = selectedScope
        }

        func updateSearchResults(for searchController: UISearchController) {
            if searchController.searchBar.selectedScopeButtonIndex == 0 {
                selectedScope = SearchCategory.appleMusic
            } else {
                selectedScope = SearchCategory.store
            }
            if text != searchController.searchBar.text {
                text = searchController.searchBar.text ?? ""
            }
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        Coordinator(text: $text, selectedScope: $selectedScope)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<SearchBar>) -> UIViewControllerType {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = context.coordinator
        searchController.searchBar.scopeButtonTitles = searchScopeTitles
        searchController.searchBar.placeholder = placeholder

        return SearchBarViewController(searchController: searchController, isSearching: $isSearching)
    }

    func updateUIViewController(_: SearchBarViewController, context _: UIViewControllerRepresentableContext<SearchBar>) {}

    // MARK: UIkit으로 검색창을 만드는 클래스

    class SearchBarViewController: UIViewController, UISearchControllerDelegate {
        var searchController: UISearchController
        @Binding var isSearching: Bool

        init(searchController: UISearchController, isSearching: Binding<Bool>) {
            self.searchController = searchController
            _isSearching = isSearching
            super.init(nibName: nil, bundle: nil)
            self.searchController.delegate = self
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func didDismissSearchController(_: UISearchController) {
            isSearching.toggle()
        }

        func didPresentSearchController(_: UISearchController) {
            isSearching.toggle()
        }

        // MARK: UIkit에서 검색창은 네비게이션바에 위치하는 아이템으로 부모뷰의 네비게이션에 UIkit 서치바를 삽입해주는 코드

        override func didMove(toParent parent: UIViewController?) {
            super.didMove(toParent: parent)
            guard let parent = parent, parent.navigationItem.searchController == nil else { return }
            parent.navigationItem.searchController = searchController
        }
    }
}

enum SearchCategory: String {
    case appleMusic = "Apple Music"
    case store = "보관함"
}
