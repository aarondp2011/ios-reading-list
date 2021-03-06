//
//  BookController.swift
//  Reading List
//
//  Created by Aaron Peterson on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    var bookDetailsVC = BookDetailViewController()
    
    var readBooks: [Book] {
        let hasRead = books.filter { $0.hasBeenRead == true }
        return hasRead
    }
    
    var unreadBooks: [Book] {
        let hasNotRead = books.filter { $0.hasBeenRead == false }
        return hasNotRead
    }
    
    func createBook(with title: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        self.saveToPersistentStore()
        return book
    }
    
    func deleteBook(bookToDelete: Book) {
        var index = 0
        for book in books {
            if book == bookToDelete {
                books.remove(at: index)
                break
            } else {
                index += 1
            }
        }
        self.saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        var isRead = !book.hasBeenRead
    }
    
    func updateBook(book: Book) {
//        guard let title = bookDetailsVC.bookTitleTextField.text, let reason = bookDetailsVC.reasonToReadTextField.text else { return }
//        book.title = title
//        book.reasonToRead = reason
//        self.saveToPersistentStore()
    }
    
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return directory.appendingPathComponent("books.plist")
    }
    
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("Error saving dooks data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
        } catch {
            NSLog("Error loading books data: \(error)")
        }
    }
}
