import Foundation

struct Profile: Decodable, Sendable, Equatable {
    let id: String
    let name: String
    let description: String
    let website: String
    let avatar: String
    let nfts: [String]
    let likes: [String]

    var avatarURL: URL? {
        URL(string: avatar)
    }

    var websiteURL: URL? {
        URL(string: website)
    }
}
