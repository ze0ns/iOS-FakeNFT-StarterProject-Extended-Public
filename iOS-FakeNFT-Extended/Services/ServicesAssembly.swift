import Observation

@Observable
@MainActor
final class ServicesAssembly {
    
    private let networkClient: NetworkClient
    private let nftStorage: AppStorage
    
    @ObservationIgnored
    private lazy var imageLoader = ImageLoader()
    
    @ObservationIgnored
    private lazy var nftService: NftService = {
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
    
    init(
        networkClient: NetworkClient,
        nftStorage: AppStorage
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
}
