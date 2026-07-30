import SwiftUI

struct TabBarView: View {
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

            CartView(viewModel: CartViewModel(service: MockCartService()))
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
                nftStorage: NftStorageImpl()
            )
        )
    
}
