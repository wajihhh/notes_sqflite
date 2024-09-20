import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final List<Book> addBooks = [
    Book('Wajih1', 'Love'),
    Book('Wajih2', 'Love'),
    Book('Wajih3', 'Love'),
    Book('Wajih4', 'Love'),
  ];

  List<Book> displayedBooks = [];
  List<Book> deletedBooks = []; // Track deleted books
  int currentBookIndex = 0;

  void addNextBook() {
    setState(() {
      if (currentBookIndex < addBooks.length) {
        displayedBooks.add(addBooks[currentBookIndex]);
        currentBookIndex++;
      }
    });
  }

  void deleteBook(int index) {
    setState(
      () {
        if (index >= 0 && index < displayedBooks.length) {
          deletedBooks.add(displayedBooks[index]); // Add to deleted books list
          displayedBooks.removeAt(index);
          // Adjust currentBookIndex if the deleted book was before the current index
          if (index < currentBookIndex) {
            currentBookIndex--;
          }
        }
      },
    );
  }

  void addDeletedBooks() {
    setState(() {
      // Add only the deleted books back
      for (var book in deletedBooks) {
        displayedBooks.add(book);
      }
      // Reset currentBookIndex to add books from the start of addBooks
      currentBookIndex = displayedBooks.length;
      // Clear the list of deleted books
      deletedBooks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: addNextBook,
            child: const Text('Add Book'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedBooks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(displayedBooks[index].title),
                  subtitle: Text(displayedBooks[index].author),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteBook(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Book {
  String title;
  String author;

  Book(this.author, this.title);
}
