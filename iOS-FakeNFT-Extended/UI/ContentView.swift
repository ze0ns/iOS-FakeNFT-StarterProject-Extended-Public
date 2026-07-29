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
            let date = try await CollectionServiceImpl(networkClient: DefaultNetworkClient(), storageCollections: CollectionsStorageImpl(), storage: CollectionStorageImpl()).loadCollectionByID(id: "49a96d73-d58f-4c01-8ce3-7d6949c980ca")
            
            print("Successfully fetched stations: \(date)")
        } catch {
            print("Error fetching stations: \(error)")
        }
    }
}
