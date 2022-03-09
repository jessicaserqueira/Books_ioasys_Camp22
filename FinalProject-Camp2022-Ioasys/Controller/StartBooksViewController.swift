//
//  StartBooksViewController.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 11/02/22.
//

import UIKit

protocol BooksDelegate {
    func updateBook()
    func showDetail(book: Books)
    func logout()
    func getUserName()
}

class StartBooksViewController: UIViewController, StoryboardInitializable {
    
    @IBOutlet var salution: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var bookPresenter: BooksDelegate?
    var books: [Books] = []
    var allBooks:[Books] = []
    var detailsBooks: DetailsFlow?
    var user: PersonResponse?
    var filterBooks: [String] = []
    var searchedWords: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        bookPresenter?.updateBook()
        bookPresenter?.getUserName()
        
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        bookPresenter?.logout()
        
    }
    
    @IBAction func closeDeteail(_ sender: UIStoryboardSegue) {
    }
}

extension StartBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return books.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let book = books[indexPath.row]
        bookPresenter?.showDetail(book: book)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension StartBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BooksCell", for: indexPath) as? BooksCell else { return UITableViewCell() }
        cell.delegate = self
        
        let book = books[indexPath.row]
        let author = [book.authors]
        guard let imageURL = book.imageUrl else { return cell }
        
        for author in author {
            cell.authorBook.text = author?.joined(separator: ", ")
        }
        cell.imageBook.load(urlString: imageURL)
        
        cell.titleBook.text = book.title
        cell.pageBook.text = String(book.pageCount ?? 0)
        cell.publisherBook.text = book.publisher
        cell.publishedBook.text = String(book.published ?? 0)
        
        return cell
    }
}

extension StartBooksViewController: FavoriteBookDelegate{
    func bookFavoriteDelegate() {
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            
            let book = books[indexPath.row]
            bookPresenter?.showDetail(book: book)
            
            return
            
        }
    }
}
extension StartBooksViewController:  UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            bookPresenter?.updateBook()
        }
        
        for word in searchText {
            if word.uppercased().contains(searchText.uppercased()){
                searchedWords.append(String(word))
            }
        }
        
        self.books = allBooks.filter { $0.title!.lowercased().contains(searchText.lowercased()) }
        
        self.tableView.reloadData()

    }
    
}
// MARK: - BooksView

extension StartBooksViewController: BooksView{
    func implement(user: PersonResponse) {
        salution.text = "Seja bem vindo, \(user.name)!"
    }
    
    func implement(books: [Books]) {
        self.books = books
        allBooks = books
        for book in books {
            guard let title = book.title else { continue }
            filterBooks.append(title)
        }
        tableView.reloadData()
    }
    
}

