import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: AppStorage
    private let profileServiceImpl: ProfileService

    init(
        networkClient: NetworkClient,
        nftStorage: AppStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.profileServiceImpl = ProfileServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }

    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }

    var profileService: ProfileService {
        profileServiceImpl
    }
}
