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

    let likesArray = [
        "b2f44171-7dcd-46d7-a6d3-e2109aacf520",
        "ca34d35a-4507-47d9-9312-5ea7053994c0",
        "1464520d-1659-4055-8a79-4593b9569e48"
    ]
    let profile = ProfileModel(name: "Студент потока 2", avatar:  "https://photo.bank/2.png", description: "Хобби велосипед и вязание", website: "https://practicum.yandex.ru/go-basics/", nfts: [], likes: likesArray, id: "7057c681-037f-4391-8ba5-4268d1a9d2b0")

    Task {
        do {
            let date = try await ProfileServiceImpl(networkClient: DefaultNetworkClient(), storage: AppStorageImpl()).updateProfileInfo(profile: profile)
            
            print("Successfully fetched stations: \(date)")
        } catch {
            print("Error fetching stations: \(error)")
        }
    }
//        Task {
//            do {
//                let date = try await ProfileServiceImpl(networkClient: DefaultNetworkClient(), storage: AppStorageImpl()).loadProfile()
//    
//                print("Successfully fetched stations: \(date)")
//            } catch {
//                print("Error fetching stations: \(error)")
//            }
//        }

}
