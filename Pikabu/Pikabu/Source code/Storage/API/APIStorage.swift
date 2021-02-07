import Foundation

//MARK: - APIStorage -
final class APIStorage: CacheProvider {
    
    //MARK: - MemoryCache -
    private class MemoryCache: CacheHandler {
        fileprivate let cache: NSCache<NSString, NSData> = .init()
        
        //MARK: MemoryCache load
        func load(_ key: String) -> Data? {
            cache.object(forKey: key.ns()) as Data?
        }
        
        //MARK: MemoryCache save
        func save(_ key: String, _ data: Data) {
            cache.setObject(data.ns(), forKey: key.ns())
        }
        
        //MARK: MemoryCache remove
        func remove() {
            cache.removeAllObjects()
        }
    }
    
    //MARK: - FileCache -
    private class FileCache: CacheHandler {
        private let fm: FileManager = .default
        private let dirName: String = Bundle.main.appName
        
        //MARK: FileCache cacheDirURL
        private func cacheDirURL() throws -> URL? {
            do {
                let directory = try fm.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(dirName, isDirectory: true)
                do {
                    try fm.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    throw error
                }
                return directory
            } catch {
                throw error
            }
        }
        
        //MARK: FileCache fileURL
        private func fileURL(_ key: String) -> URL? {
            if let path = key.addingPercentEncoding(withAllowedCharacters: .alphanumerics) {
                do {
                    let dir = try cacheDirURL()
                    return dir?.appendingPathComponent(path)
                } catch {
                    NSLog("Error get cache dir:\n\(error)")
                    return nil
                }
            } else {
                return nil
            }
        }
        
        //MARK: FileCache load
        func load(_ key: String) -> Data? {
            guard let path = fileURL(key) else { return nil }
            do {
                return try Data(contentsOf: path)
            } catch {
                // NSLog("Couldn't create data object:\n\(error)")
                return nil
            }
        }
        
        //MARK: FileCache save
        func save(_ key: String, _ data: Data) {
            guard let path = fileURL(key) else { return }
            do {
                try data.write(to: path, options: .atomic)
            } catch {
                NSLog("Failed to write data to file:\n\(error)")
            }
        }
        
        //MARK: FileCache remove
        func remove() {
            do {
                guard let cachesDir = try cacheDirURL() else { return }
                do {
                    try fm.removeItem(at: cachesDir)
                } catch {
                    NSLog("Failed to deleting files from the cache dir:\n\(error)")
                }
            } catch {
                NSLog("Failed to get dir path:\n\(error)")
            }
        }
        
        //MARK: FileCache init
        fileprivate init() { }
    }
    
    static public var shared: CacheProvider = APIStorage()
    
    //MARK: APIStorage's Handlers
    internal var memory: CacheHandler
    internal var disk: CacheHandler
    public var ud: UserDefaults
    
    //MARK: APIStorage subscript
    public subscript(key: String) -> Data? {
        get {
            guard let result = memory.load(key) else {
                if let datafile = disk.load(key) {
                    memory.save(key, datafile)
                    return datafile
                }
                return nil
            }
            return result
        }
        set (newdata) {
            guard let data = newdata else { return }
            memory.save(key, data)
            disk.save(key, data)
            // ud.set(data, forKey: key)
            // ud.synchronize()
        }
    }
    
    //MARK: APIStorage remove
    func remove() {
        memory.remove()
        disk.remove()
    }
    
    //MARK: APIStorage init
    fileprivate init() {
        self.memory = MemoryCache()
        self.disk = FileCache()
        self.ud = .standard
    }
}
