import SwiftUI

struct TabBarView: View {
    @Environment(ServicesAssembly.self) var servicesAssembly
    @State private var cartRouter = CartRouter()
    
    var body: some View {
        TabView {
            TabPlaceholderView(
                title: NSLocalizedString("Tab.profile", comment: ""),
                systemImage: "person.crop.circle.fill"
            )
            .tabItem {
                Label(
                    NSLocalizedString("Tab.profile", comment: ""),
                    systemImage: "person.crop.circle.fill"
                )
            }
            
            TestCatalogView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.catalog", comment: ""),
                        systemImage: "square.stack.3d.up.fill"
                    )
                }
                .backgroundStyle(.background)
            
            CartFlowView(cartViewModel: CartViewModel(service: servicesAssembly.cartServiceProvider),
                         paymentViewModel: PaymentViewModel(service: servicesAssembly.currencyServiceProvider),
                         imageLoader: servicesAssembly.imageLoaderProvider)
            
                        .tabItem {
                            Label(
                                NSLocalizedString("Tab.cart", comment: ""),
                                systemImage: "bag.fill"
                            )
                        }
                        
            TabPlaceholderView(
                title: NSLocalizedString("Tab.statistics", comment: ""),
                systemImage: "flag.2.crossed.fill"
            )
            .tabItem {
                Label(
                    NSLocalizedString("Tab.statistics", comment: ""),
                    systemImage: "flag.2.crossed.fill"
                )
            }
        }
    }
}

#Preview {
    TabBarView()
        .environment(
            ServicesAssembly(
                networkClient: DefaultNetworkClient(),
                nftStorage: AppStorageImpl()
            )
        )
    
}
