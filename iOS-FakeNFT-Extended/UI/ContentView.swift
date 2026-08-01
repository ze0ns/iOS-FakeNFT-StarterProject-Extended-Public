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

        let nfts =  [
            "b2f44171-7dcd-46d7-a6d3-e2109aacf520",
            "d02ecb5a-2e45-4b82-9f6b-9200e0eec88a",
            "eb959204-76cc-46ef-ba07-aefa036ca1a5",
            "ca34d35a-4507-47d9-9312-5ea7053994c0",
            "1464520d-1659-4055-8a79-4593b9569e48"
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
