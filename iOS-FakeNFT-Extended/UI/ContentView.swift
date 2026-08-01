import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabBarView()
            .onAppear{
                fetchStations()
                
            }
        
    }
}
func fetchStations() {
    //    let profile = ProfileDTO(name: "Студентус Практикумс", avatar:  "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/557.jpg", description: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100 NFT, и еще больше — на моём сайте.", website: "https://practicum.yandex.ru/interface-designer/", nfts: [], likes: [], id: "7057c681-037f-4391-8ba5-4268d1a9d2b0")
    let nfts = [
        "b2f44171-7dcd-46d7-a6d3-e2109aacf520",
        "ca34d35a-4507-47d9-9312-5ea7053994c0",
        "1464520d-1659-4055-8a79-4593b9569e48",
        "db196ee3-07ef-44e7-8ff5-16548fc6f434",
        "1e649115-1d4f-4026-ad56-9551a16763ee"
    ]
    Task {
        do {
            let date = try await OrdersServiceImpl(networkClient: DefaultNetworkClient(), storage: AppStorageImpl()).updateOrders(orders: nfts)
            
            print("Successfully fetched stations: \(date)")
        } catch {
            print("Error fetching stations: \(error)")
        }
    }

}
