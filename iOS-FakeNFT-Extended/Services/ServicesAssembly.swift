import Observation

@Observable
@MainActor
final class ServicesAssembly {
    
    private let networkClient: NetworkClient
<<<<<<< HEAD
    private let nftStorage: StorageService
    
    @ObservationIgnored
    private lazy var imageLoader = ImageLoader()
    
    @ObservationIgnored
    private lazy var nftService: NftService = {
=======
    private let nftStorage: AppStorage
    private let profileServiceImpl: ProfileService
    private let myNftServiceImpl: MyNftService

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
        self.myNftServiceImpl = MyNftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }

    var nftService: NftService {
>>>>>>> develop
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }()
    
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
    private lazy var currencyService: CurrencyService = {
        CurrencyServiceImpl(
            networkClient: networkClient,
            storage: nftStorage,
        )
    }()
    
    @ObservationIgnored
    private lazy var cryptoCurrencyService: CryptoCurrencyServiceProtocol = {
        CryptoCurrencyService(currencyService: currencyService)
    }()
    
    init(
        networkClient: NetworkClient,
        nftStorage: StorageService
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }
    
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
