import Foundation

/// Объект передачи данных, описывающий NFT, получаемый от сервера.
struct Nft: Codable, Sendable, Identifiable {

    /// Идентификатор NFT.
    let id: String

    /// Название NFT.
    let name: String

    /// Ссылки на изображения NFT.
    let images: [URL]

    /// Рейтинг NFT от 1 до 5.
    let rating: Int

    /// Цена NFT в ETH.
    let price: Double

    /// Имя автора NFT.
    let author: String

    /// Первое изображение NFT, используется как обложка в списках.
    var coverURL: URL? { images.first }
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
