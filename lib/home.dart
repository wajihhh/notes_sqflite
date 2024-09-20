// //
// //
// //
// // void main() {
// //   Book book1 = Book('1988', 'George', '21312', true);
// //   Book book2 = Book('GOT', 'Harper', '88349', true);
// //
// //   Library library = Library();
// //   library.addBook(book1);
// //   library.addBook(book2);
// //   library.listBook();
// //   Member member = Member('John', 'M001');
// //   library.loansBook(book1, member);
// //
// //   library.listLoanBook();
// // }
// //
// // class Book {
// //   String title;
// //   String author;
// //   String isbn;
// //   bool isAvailable;
// //
// //   Book(this.title, this.author, this.isbn, this.isAvailable);
// // }
// //
// // class Library {
// //   List<Book> books = [];
// //   List<Loan> loans = [];
// //
// //   void loansBook(Book book, Member member){
// //     if(book.isAvailable){
// //       book.isAvailable= false;
// //       loans.add(Loan(member, book, DateTime.now()));
// //
// //     }else{
// //       print('${book.title} is not available');
// //     }
// //   }
// //   void addBook(Book book) {
// //     books.add(book);
// //   }
// //
// //   void listBook() {
// //     for (var book in books) {
// //       print(
// //           'Title: ${book.title}, Author: ${book.author}, isbn: ${book.isbn}, Available:${book.isAvailable}');
// //     }
// //   }
// //
// //   void listLoanBook() {
// //     for (var loan in loans) {
// //       print(
// //           'Title: ${loan.book.title}, Author: ${loan.book.author}, isbn: ${loan.book.isbn}, Available:${loan.book.isAvailable}');
// //     }
// //   }
// // }
// //
// // class Member {
// //   String name;
// //   String memberId;
// //
// //   Member(this.name, this.memberId);
// // }
// //
// // class Loan {
// //   Book book;
// //   Member member;
// //   DateTime loanDate;
// //   DateTime? returnDate;
// //
// //   Loan(this.member,this.book, this.loanDate, [this.returnDate]);
// //
// //   void returnBook(){
// //     returnDate=DateTime.now();
// //     book.isAvailable = true;
// //
// //   }
// //
// //
// // }
//
//
// import 'package:flutter/material.dart';
//
//
//
// class LibraryHomePage extends StatefulWidget {
//   @override
//   _LibraryHomePageState createState() => _LibraryHomePageState();
// }
//
// class _LibraryHomePageState extends State<LibraryHomePage> {
//   Library library = Library();
//   Member member = Member('John', 'M001');
//   Book book1 = Book('1988', 'George', '21312', true);
//   Book book2 = Book('GOT', 'Harper', '88349', true);
//
//   @override
//   void initState() {
//     super.initState();
//     // Adding some initial books
//     library.addBook(book1);
//     library.addBook(book2);
//   }
//   final List<Book> booksToAdd = [
//     Book('The Catcher in the Rye', 'J.D. Salinger', '0316769487', true),
//     Book('To Kill a Mockingbird', 'Harper Lee', '0446310786', true),
//     Book('Pride and Prejudice', 'Jane Austen', '0679783261', true),
//     Book('The Great Gatsby', 'F. Scott Fitzgerald', '0743273567', true),
//     Book('1984', 'George Orwell', '0451524934', true),
//     Book('Moby-Dick', 'Herman Melville', '1503280780', true),
//   ];
//   void addNextBook() {
//     if (currentBookIndex < booksToAdd.length) {
//       library.addBook(booksToAdd[currentBookIndex]);
//       currentBookIndex++;
//       setState(() {});
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All books have been added')));
//       // Show a message or handle the case when all books are added
//       print('All books have been added');
//     }
//   }
//
//   int currentBookIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Library Management'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed:addNextBook,
//             child: Text('Add Book'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 library.loansBook(book1,member);
//               });
//             },
//             child: Text('Loan First Book to Member'),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 Text('Books:'),
//                 ...library.books.map((book) => ListTile(
//                   title: Text(book.title),
//                   subtitle: Text(
//                       'Author: ${book.author}, ISBN: ${book.isbn}, Available: ${book.isAvailable}'),
//                 )),
//                 SizedBox(height: 20),
//                 Text('Loaned Books:'),
//                 ...library.loans.map((loan) => ListTile(
//                   title: Text('Title: ${loan.book.title}, Author: ${loan.book.author}, ISBN: ${loan.book.isbn}, Available: ${loan.book.isAvailable}'),
//                   subtitle: Text(
//                       'Loaned by: ${loan.member.name}, Loan Date: ${loan.loanDate}'),
//                 )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Book {
//   String title;
//   String author;
//   String isbn;
//   bool isAvailable;
//
//   Book(this.title, this.author, this.isbn, this.isAvailable);
// }
//
// class Library {
//   List<Book> books = [];
//   List<Loan> loans = [];
//
//   void loansBook(Book book, Member member) {
//     if (book.isAvailable) {
//       book.isAvailable = false;
//       loans.add(Loan(member, book, DateTime.now()));
//     } else {
//       print('${book.title} is not available');
//     }
//   }
//
//   void addBook(Book book) {
//     books.add(book);
//   }
// }
//
// class Member {
//   String name;
//   String memberId;
//
//   Member(this.name, this.memberId);
// }
//
// class Loan {
//   Book book;
//   Member member;
//   DateTime loanDate;
//   DateTime? returnDate;
//
//   Loan(this.member, this.book, this.loanDate, [this.returnDate]);
//
//   void returnBook() {
//     returnDate = DateTime.now();
//     book.isAvailable = true;
//   }
// }

import 'package:flutter/material.dart';
import 'package:practice/home_page.dart';
import 'package:practice/note_screen2.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotesScreen()));
                },
                child: const Text('Notes 1')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: const Text('Notes 2'))
          ],
        ),
      ),
    );
  }
}
