
import Combine
import FirebaseAuth

class CardListViewModel: ObservableObject {
  
  //> Important: The `@Published` attribute is class constrained. Use it with properties of classes, not with non-class types like structures.
  var cardRepository = CardRespository()
  
  var currentUserID: String? {
    Auth.auth().currentUser?.uid
  }
  
  @Published var cardViewModels: [CardViewModel] = []
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    cardRepository
      .$cards
      .map { cards in
        cards.map{ CardViewModel.init(card: $0) }
      }
      .assign(to: \.cardViewModels , on: self)
      .store(in: &cancellables)
  }
  
  
  func add(_ card: Card) {
    cardRepository.add(card)
  }
  
}///End of  Card List VM

