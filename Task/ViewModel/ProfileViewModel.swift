//
//  ProfileViewModel.swift
//  Task
//
//  Created by Sahitya on 11/08/24.
//

import Foundation
import Combine
import Alamofire
import CoreData

class ProfileViewModel: ObservableObject {
    @Published var responseModel: ProfileResponse?
    @Published var profiles: [ProfileEntry]?
    private var cancellables = Set<AnyCancellable>()
    private let context: NSManagedObjectContext
    let reachabilityManager = NetworkReachabilityManager()

    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
        fetchProfilesFromCoreData()
    }
   
    func fetchProfilesFromAPI() {
        
        reachabilityManager?.startListening(onUpdatePerforming: { (status) in
            switch status {
            case .notReachable:
                print("No internet connection.")
                return
            case .reachable(_), .unknown:
                let url = "https://randomuser.me/api/?results=10%60"
                AF.request(url)
                    .responseString { response in
                        switch response.result {
                        case .success(let jsonString):
                            print("Raw JSON: \(jsonString)")
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
                    .publishDecodable(type: ProfileResponse.self)
                    .value()
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            print("Error fetching profiles: \(error)")
                        case .finished:
                            break
                        }
                    }, receiveValue: { [weak self] profile in
                        print(profile)
                        self?.responseModel = profile
                        self?.saveProfilesToCoreData(profiles: profile.results ?? [])
                    })
                    .store(in: &self.cancellables)
            }
        })
    }
    
    func fetchProfilesFromCoreData() {
        let request: NSFetchRequest<ProfileEntry> = ProfileEntry.fetchRequest()
        do {
            profiles = try context.fetch(request)
        } catch {
            print("Failed to fetch profiles: \(error)")
        }
    }
    
    // Method to save profiles from API to Core Data
     func saveProfilesToCoreData(profiles: [Results]) {
        for profile in profiles {
            let entity = ProfileEntry(context: context)
            //entity.id = profile.id?.value
            // entity.id = profile.id
            entity.name = (profile.name?.first ?? "") + " " + (profile.name?.last ?? "")
            entity.age = String(profile.dob?.age ?? 0)
            let address = "\(profile.location?.street?.number ?? 0)" + ", " + "\(profile.location?.street?.name ?? "")" + ", " + "\(profile.location?.city ?? "")" + ", " + "\(profile.location?.state ?? "")"
            entity.location = address
            entity.imageName = profile.picture?.medium
            entity.status = nil // Default status
            
            do {
                try context.save() // Save each profile to Core Data
            } catch {
                print("Failed to save profile: \(error)")
            }
        }
        fetchProfilesFromCoreData() // Refresh the profiles list after saving
    }
    
    func updateProfileStatus(profile: ProfileEntry, status: String) {
        profile.status = status
        
        do {
            try context.save()
        } catch {
            print("Failed to update profile status: \(error)")
        }
        
        fetchProfilesFromCoreData()
    }
}
