import UIKit

enum NetworkError: Error {
    case httpStatusCode(Int)
    case parsingError
    case urlSessionError
    case requestError
}

final class NetworkClient: NetworkClientProtocol {
    
    // MARK: - Classes:
    let urlSession = URLSession.shared
    
    // MARK: - Public Methods:
    func fetchData<T: Decodable>(with urlString: String, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        
        urlSession.dataTask(with: request) { data, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                completion(.failure(NetworkError.urlSessionError))
                return
            }
            
            guard 200...300 ~= statusCode else {
                completion(.failure(NetworkError.httpStatusCode(statusCode)))
                return
            }
            
            if let data {
                self.pars(to: model, with: data, completion: completion)
            }
            
            if error != nil {
                completion(.failure(NetworkError.requestError))
            }
        }
        .resume()
    }
    
    // MARK: - Supporting Methods:
    private func pars<T: Decodable>(to model: T.Type, with data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        let decoder = JSONDecoder()
        
        do {
            let model = try decoder.decode(T.self, from: data)
            completion(.success(model))
        } catch {
            completion(.failure(NetworkError.parsingError))
        }
    }
}
