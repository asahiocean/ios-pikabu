import Foundation

class Storage {
    
    static let shared = Storage()
    
    let posts: StorageModel
    let liked: StorageModel
    let favorites: StorageModel
    
    private var likedObserver: NSKeyValueObservation?
    private var favoritesObserver: NSKeyValueObservation?
    
    private(set) var likedList: [Int] = []
    private(set) var favList: [Int] = []
    
    fileprivate init() {
        (posts,liked,favorites) = (.init(),.init(),.init())
        
        let favListKey = "favListKey"
        let likedListKey = "likedListKey"
        let defaults = UserDefaults.standard
        
        likedList = defaults.value(forKey: likedListKey) as? [Int] ?? []
        favList = defaults.value(forKey: favListKey) as? [Int] ?? []
        
        listObserver(o: &likedObserver, s: liked, k: likedListKey, { self.likedList = $0 })
        listObserver(o: &favoritesObserver, s: favorites, k: favListKey, { self.favList = $0 })
    }
}

extension Storage {
    fileprivate func listObserver(o observer: inout NSKeyValueObservation?, s storage: StorageModel,
                                  k userDefaultsKey: String, _ completion: @escaping ([Int]) -> ()) {
        observer = storage.observe(\.feed, options: .new) { obj, change in
            guard let feed = change.newValue else { return }
            let result = feed.map({ $0.id })
            DispatchQueue.main.async {
                UserDefaults.standard.set(result, forKey: userDefaultsKey)
                completion(result)
            }
        }
    }
}
