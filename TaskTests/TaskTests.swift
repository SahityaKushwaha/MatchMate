//
//  TaskTests.swift
//  TaskTests
//
//  Created by Sahitya on 12/08/24.
//

import XCTest
import CoreData
import Combine
@testable import Task

final class ProfileViewModelTests: XCTestCase {
    var viewModel: ProfileViewModel!
    var mockContext: NSManagedObjectContext!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()

        // Create an in-memory persistent container
        let container = NSPersistentContainer(name: "Task")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        // Load the persistent store
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }

        mockContext = container.viewContext
        viewModel = ProfileViewModel(context: mockContext)
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockContext = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    func testFetchProfilesFromCoreData() throws {
        // Given: Prepare some test data in Core Data
        let testProfile = ProfileEntry(context: mockContext)
        testProfile.name = "John Doe"
        testProfile.age = "30"
        testProfile.location = "123 Main St, City, State"
        testProfile.imageName = "image_url"
        testProfile.status = "Accepted"

        try mockContext.save()

        // When: Fetch profiles from Core Data
        viewModel.fetchProfilesFromCoreData()

        // Then: Assert that the profiles array contains the test profile
        XCTAssertEqual(viewModel.profiles?.count, 1)
        XCTAssertEqual(viewModel.profiles?.first?.name, "John Doe")
    }

    func testSaveProfilesToCoreData() throws {
        // Given: A list of mock API profiles
        let mockResults = [
            Results(name: Name(first: "Jane", last: "Doe"), dob: Dob(age: 25))
        ]
        // When: Save profiles to Core Data
        viewModel.saveProfilesToCoreData(profiles: mockResults)

        // Then: Fetch profiles from Core Data and assert that they were saved
        viewModel.fetchProfilesFromCoreData()

        XCTAssertEqual(viewModel.profiles?.count, 1)
        XCTAssertEqual(viewModel.profiles?.first?.name, "Jane Doe")
        XCTAssertEqual(viewModel.profiles?.first?.age, "25")
    }

    func testUpdateProfileStatus() throws {
        // Given: Prepare a test profile in Core Data
        let testProfile = ProfileEntry(context: mockContext)
        testProfile.name = "John Doe"
        testProfile.age = "30"
        testProfile.location = "123 Main St, City, State"
        testProfile.imageName = "image_url"
        testProfile.status = "Inactive"

        try mockContext.save()

        // When: Update the profile status
        viewModel.updateProfileStatus(profile: testProfile, status: "Accepted")

        // Then: Fetch profiles from Core Data and assert that the status was updated
        viewModel.fetchProfilesFromCoreData()

        XCTAssertEqual(viewModel.profiles?.first?.status, "Accepted")
    }

    func testFetchProfilesFromAPI_withInternet() {
        viewModel.fetchProfilesFromAPI()

        // Assert that no profiles are fetched
        XCTAssertNil(viewModel.responseModel)
    }
}
