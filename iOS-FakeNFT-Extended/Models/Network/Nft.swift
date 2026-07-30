import Foundation

struct Nft: Codable {
    let id: String
    let images: [URL]
}

struct NftArrayElement: Codable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Double
    let author: String
    let website: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case name = "name"
        case images = "images"
        case rating = "rating"
        case description = "description"
        case price = "price"
        case author = "author"
        case website = "website"
        case id = "id"
    }
}
