// Получение NFT по ID , необходимо отправить ID NFT в ответ прийдет массив со ссылками на изображения NFT

import Foundation

protocol NftService {
    func loadNft(id: String) async throws -> Nft
    func loadArrayNft() async throws -> [NftArrayElement]
}

@MainActor
final class NftServiceImpl: NftService {
    
    private let networkClient: NetworkClient
    private let storage: StorageService
    
    init(networkClient: NetworkClient, storage: StorageService) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadNft(id: String) async throws -> Nft {
        if let nft = await storage.getNft(with: id) {
            return nft
        }
        
        let request = APIRequest.nft(id: id)
        let nft: Nft = try await networkClient.send(request: request)
        await storage.saveNft(nft)
        return nft
    }
    
    func loadArrayNft() async throws -> [NftArrayElement] {
        let request = APIRequest.arrayNft(page: "1")
        let nft: [NftArrayElement] = try await networkClient.send(request: request)
        await storage.saveArrayNft(nft)
        return nft
    }
    
}
