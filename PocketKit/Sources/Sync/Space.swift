// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import CoreData

class Space {
    private let container: PersistentContainer

    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    required init(container: PersistentContainer) {
        self.container = container
    }

    func managedObjectID(forURL url: URL) -> NSManagedObjectID? {
        container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: url)
    }

    func fetchSavedItem(byRemoteID remoteID: String) throws -> SavedItem? {
        let request = Requests.fetchSavedItem(byRemoteID: remoteID)
        return try context.fetch(request).first
    }

    func fetchSavedItem(byRemoteItemID remoteItemID: String) throws -> SavedItem? {
        let request = Requests.fetchSavedItem(byRemoteItemID: remoteItemID)
        return try context.fetch(request).first
    }

    func fetchSavedItem(byURL url: URL) throws -> SavedItem? {
        let request = Requests.fetchSavedItem(byURL: url)
        return try context.fetch(request).first
    }

    func fetchSavedItems() throws -> [SavedItem] {
        let request = Requests.fetchSavedItems()
        let results = try context.fetch(request)
        return results
    }

    func fetchArchivedItems() throws -> [SavedItem] {
        return try fetch(Requests.fetchArchivedItems())
    }

    func fetchAllSavedItems() throws -> [SavedItem] {
        return try fetch(Requests.fetchAllSavedItems())
    }
    
    func fetchOrCreateSavedItem(byRemoteID itemID: String) throws -> SavedItem {
        try fetchSavedItem(byRemoteID: itemID) ?? new()
    }

    func fetchPersistentSyncTasks() throws -> [PersistentSyncTask] {
        return try fetch(Requests.fetchPersistentSyncTasks())
    }

    func fetchSavedItemUpdatedNotifications() throws -> [SavedItemUpdatedNotification] {
        return try fetch(Requests.fetchSavedItemUpdatedNotifications())
    }

    func fetchUnresolvedSavedItems() throws -> [UnresolvedSavedItem] {
        return try fetch(Requests.fetchUnresolvedSavedItems())
    }

    func fetchSlateLineups() throws -> [SlateLineup] {
        return try fetch(Requests.fetchSlateLineups())
    }

    func fetchSlateLineup(byRemoteID id: String) throws -> SlateLineup? {
        return try fetch(Requests.fetchSlateLineup(byID: id)).first
    }

    func fetchOrCreateSlateLineup(byRemoteID id: String) throws -> SlateLineup {
        try fetchSlateLineup(byRemoteID: id) ?? new()
    }

    func fetchSlates() throws -> [Slate] {
        return try fetch(Requests.fetchSlates())
    }

    func fetchSlate(byRemoteID id: String) throws -> Slate? {
        let request = Requests.fetchSlates()
        request.predicate = NSPredicate(format: "remoteID = %@", id)
        request.fetchLimit = 1
        return try fetch(request).first
    }

    func fetchOrCreateSlate(byRemoteID id: String) throws -> Slate {
        return try fetchSlate(byRemoteID: id) ?? new()
    }

    func fetchRecommendations() throws -> [Recommendation] {
        return try fetch(Requests.fetchRecommendations())
    }

    func fetchRecommendation(byRemoteID id: String) throws -> Recommendation? {
        let request = Requests.fetchRecommendations()
        request.predicate = NSPredicate(format: "remoteID = %@", id)
        request.fetchLimit = 1
        return try fetch(request).first
    }

    func fetchOrCreateRecommendation(byRemoteID id: String) throws -> Recommendation {
        return try fetchRecommendation(byRemoteID: id) ?? new()
    }

    func fetchItems() throws -> [Item] {
        return try fetch(Requests.fetchItems())
    }

    func fetchItem(byRemoteID id: String) throws -> Item? {
        return try fetch(Requests.fetchItem(byRemoteID: id)).first
    }

    func fetchOrCreateItem(byRemoteID id: String) throws -> Item {
        return try fetchItem(byRemoteID: id) ?? new()
    }

    func fetchUnsavedItems() throws -> [Item] {
        return try fetch(Requests.fetchUnsavedItems())
    }

    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] {
        try context.fetch(request)
    }

    func new<T: NSManagedObject>() -> T {
        return T(context: context)
    }

    func delete(_ object: NSManagedObject) {
        context.delete(object)
    }

    func delete(_ objects: [NSManagedObject]) {
        objects.forEach(context.delete(_:))
    }

    func deleteUnsavedItems() throws {
        try delete(fetchUnsavedItems())
    }

    func save() throws {
        try context.obtainPermanentIDs(for: Array(context.insertedObjects))
        try context.save()
    }
    
    func clear() throws {
        let context = container.viewContext
        for entity in container.managedObjectModel.entities {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity.name!)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try context.execute(deleteRequest)
        }
    }

    func makeItemsController() -> NSFetchedResultsController<SavedItem> {
        NSFetchedResultsController(
            fetchRequest: Requests.fetchSavedItems(),
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }

    func makeArchivedItemsController() -> NSFetchedResultsController<SavedItem> {
        NSFetchedResultsController(
            fetchRequest: Requests.fetchArchivedItems(),
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }

    func makeSlateLineupController() -> NSFetchedResultsController<SlateLineup> {
        let request = Requests.fetchSlateLineups()
        request.fetchLimit = 1
        request.sortDescriptors = [NSSortDescriptor(key: "requestID", ascending: true)]
        return NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }

    func makeSlateController(byID id: String) -> NSFetchedResultsController<Slate> {
        let request = Requests.fetchSlate(byID: id)
        request.sortDescriptors = [NSSortDescriptor(key: "remoteID", ascending: true)]
        return NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }

    func makeUndownloadedImagesController() -> NSFetchedResultsController<Image> {
        let request = Requests.fetchUndownloadedImages()
        request.sortDescriptors = [NSSortDescriptor(key: "source.absoluteString", ascending: true)]
        return NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }

    func object<T: NSManagedObject>(with id: NSManagedObjectID) -> T? {
        context.object(with: id) as? T
    }

    func refresh(_ object: NSManagedObject, mergeChanges: Bool) {
        context.refresh(object, mergeChanges: mergeChanges)
    }
}
