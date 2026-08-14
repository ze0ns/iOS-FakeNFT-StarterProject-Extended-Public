import Observation

@Observable
@MainActor
final class ServicesAssembly {
    
    private let networkClient: NetworkClient
    private let nftStorage: StorageService
    private let profileServiceImpl: ProfileService
    private let myNftServiceImpl: MyNftService

    @ObservationIgnored
    private lazy var imageLoader = ImageLoader()
    
    @ObservationIgnored
    private lazy var nftService: NftService = {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }()

    init(
        networkClient: NetworkClient,
        nftStorage: StorageService
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.profileServiceImpl = ProfileServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
        self.myNftServiceImpl = MyNftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    
    @ObservationIgnored
    private lazy var ordersService: OrdersService = {
        OrdersServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }()
    
    @ObservationIgnored
    private lazy var cartService: CartServiceProtocol = {
        CartService(
            nftService: nftService,
            ordersService: ordersService
        )
    }()
    
    @ObservationIgnored
    private lazy var currencyService: CurrenciesServiceImpl = {
        CurrenciesServiceImpl(
            networkClient: networkClient,
            storage: nftStorage,
        )
    }()
    
    @ObservationIgnored
    private lazy var cryptoCurrencyService: CryptoCurrencyServiceProtocol = {
        CryptoCurrencyService(currencyService: currencyService)
    }()
    
    var nftServiceProvider: NftService {
        nftService
    }
    
    var cartServiceProvider: CartServiceProtocol {
        cartService
    }
    
    var imageLoaderProvider: ImageLoader {
        imageLoader
    }
    
    var ordersServiceProvider: OrdersService {
        ordersService
    }
    
    var currencyServiceProvider: CryptoCurrencyServiceProtocol {
        cryptoCurrencyService
    }

    var profileService: ProfileService {
        profileServiceImpl
    }

    var myNftService: MyNftService {
        myNftServiceImpl
    }
}
