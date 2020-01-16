import SwiftUI
import Combine

public class ImageLoader: ObservableObject {
    
    public var dataPublisher = PassthroughSubject<Data, Never>()

    private var data = Data() {
        didSet {
            dataPublisher.send(data)
        }
    }

    public init(urlString: String) {

        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
