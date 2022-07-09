
import SwiftUI

class SearchBarViewController: UIViewController {
    var searchController = UISearchController()
    
    init(searchController: UISearchController) {
        self.searchController = searchController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        guard let parent = parent, parent.navigationItem.searchController == nil else  {return}
        parent.navigationItem.searchController = searchController
    }
}

struct SearchBar<Content: View>: UIViewControllerRepresentable {

    typealias UIViewControllerType = SearchBarViewController
    
    var placeholder: String = "아티스트, 노래, 가사 등"
    @Binding var text: String
    
    @ViewBuilder var content: () -> Content

    class Coordinator: NSObject, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {

        @Binding var text: String
        init(text: Binding<String>) {
            _text = text
        }

        func updateSearchResults(for searchController: UISearchController) {

            if( self.text != searchController.searchBar.text ) {
                self.text = searchController.searchBar.text ?? ""
            }
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<SearchBar>) -> UIViewControllerType {

        let searchController =  UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = context.coordinator
        searchController.searchBar.scopeButtonTitles = ["Apple music", "보관함"]
        searchController.searchBar.placeholder = placeholder
        searchController.obscuresBackgroundDuringPresentation = false
        return SearchBarViewController(searchController: searchController)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<SearchBar>) {
    }
}

