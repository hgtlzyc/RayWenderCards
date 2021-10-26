/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

/// A type of object with a publisher that emits before the object has changed.
///
/// By default an ``ObservableObject`` synthesizes an ``ObservableObject/objectWillChange-2oa5v`` publisher that emits the changed value before any of its `@Published` properties changes.
                        
                        
class CardRespository {
  
  private let pathForCardsCollection: String = "cards"
  private let store = Firestore.firestore()
  
  @Published var cards: [Card] = []
  
  init() {
    get()
  }
  
  // MARK: - CRUD Functions
  
  //create
  func add(_ card: Card) {
    
    do {
      
      try store.collection(pathForCardsCollection)
        .document(card.id)
        .setData(from: card) { err in
          guard let error = err else { return }
          print("unable to create new card in \(#file) with \(error.localizedDescription)")
        }

    } catch {
      print("error in \(#function) with \(error)")
    }
    
  }///End of  add
  
  
  //read
  func get() {
    store.collection( pathForCardsCollection )
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("error in function \(#function) \(error.localizedDescription)")
          return
        }
        
        guard let qs = querySnapshot else { return }
        
        self.cards = qs.documents.compactMap { doc in
          try? doc.data(as: Card.self)
        }
        
      }///End of  snapShootListenerCallBack
  }///End of get()

  //update
  //func update(card: Card, with)
  
}///End of  CardRespository
