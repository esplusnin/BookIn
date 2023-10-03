import Foundation

struct Hotel: Codable {
    let id: Int
    let name, adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageURLs: [String]
    let aboutTheHotel: AboutTheHotel
    
    enum CodingKeys: String, CodingKey {
        case id, name, adress
        case minimalPrice = "minimal_price"
        case priceForIt = "price_for_it"
        case rating
        case ratingName = "rating_name"
        case imageURLs = "image_urls"
        case aboutTheHotel = "about_the_hotel"
    }
}
