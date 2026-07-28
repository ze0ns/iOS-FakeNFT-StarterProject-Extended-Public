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
            let users = try await UsersInfoImpl(networkClient: DefaultNetworkClient(), storage: UsersStorageImpl()).loadUsersInfo(page: "1")
            print("Successfully fetched stations: \(users)")
        } catch {
            print("Error fetching stations: \(error)")
        }
    }
}
//try await NftServiceImpl(networkClient: DefaultNetworkClient(), storage: NftStorageImpl()).loadNft(id: "594aaf01-5962-4ab7-a6b5-470ea37beb93")
