import UIKit

enum NetworkError: Error {
    case httpStatusCode(Int)
    case parsingError
    case urlSessionError
    case requestError(Error)
}

final class NetworkClient: NetworkClientProtocol {
    
    // MARK: - Classes:
    let urlSession = URLSession.shared
    
    // MARK: - Public Methods:
    func fetchData<T: Decodable>(with urlString: String, model: T, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
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
            
            if let error {
                completion(.failure(NetworkError.requestError(error)))
            }
        }
    }
    
    // MARK: - Supporting Methods:
    private func pars<T: Decodable>(to model: T, with data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        let decoder = JSONDecoder()
        
        do {
            let model = try decoder.decode(T.self, from: data)
            completion(.success(model))
        } catch {

        }
    }
}
