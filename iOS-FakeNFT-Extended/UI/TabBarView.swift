import SwiftUI

struct TabBarView: View {
    @Environment(ServicesAssembly.self) private var servicesAssembly

    var body: some View {
        TabView {
            ProfileView(profileService: servicesAssembly.profileService)
                .tabItem {
                    tabLabel(for: .profile)
                }

            TestCatalogView()
                .tabItem {
                    tabLabel(for: .catalog)
                }
                .backgroundStyle(.background)

            placeholder(for: .cart)
                .tabItem {
                    tabLabel(for: .cart)
                }

            placeholder(for: .statistics)
                .tabItem {
                    tabLabel(for: .statistics)
                }
        }
    }

    private func tabLabel(for tab: Tab) -> some View {
        Label(
            NSLocalizedString(tab.titleKey, comment: ""),
            systemImage: tab.systemImage
        )
    }

    private func placeholder(for tab: Tab) -> some View {
        TabPlaceholderView(
            title: NSLocalizedString(tab.titleKey, comment: ""),
            systemImage: tab.systemImage
        )
    }

    private enum Tab {
        case profile
        case catalog
        case cart
        case statistics

        var titleKey: String {
            switch self {
            case .profile:
                "Tab.profile"
            case .catalog:
                "Tab.catalog"
            case .cart:
                "Tab.cart"
            case .statistics:
                "Tab.statistics"
            }
        }

        var systemImage: String {
            switch self {
            case .profile:
                "person.crop.circle.fill"
            case .catalog:
                "square.stack.3d.up.fill"
            case .cart:
                "bag.fill"
            case .statistics:
                "flag.2.crossed.fill"
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
