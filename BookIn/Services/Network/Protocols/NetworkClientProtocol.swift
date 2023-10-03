import Foundation

protocol NetworkClientProtocol: AnyObject {
    func fetchData<T: Decodable>(with urlString: String, model: T, completion: @escaping (Result<T, Error>) -> Void)
}
