import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: AppStorage

    init(
        networkClient: NetworkClient,
        nftStorage: AppStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }

    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    
    var cartService: CartServiceProtocol {
        CartService(
            nftService: nftService
        )
    }
}
