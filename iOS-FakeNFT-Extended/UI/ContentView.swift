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
    Task {
        do {
            let nft = try await NftServiceImpl(networkClient: DefaultNetworkClient(), storage: NftStorageImpl()).loadNft(id: "594aaf01-5962-4ab7-a6b5-470ea37beb93")
            print("Successfully fetched stations: \(nft)")
        } catch {
            print("Error fetching stations: \(error)")
        }
    }
}
