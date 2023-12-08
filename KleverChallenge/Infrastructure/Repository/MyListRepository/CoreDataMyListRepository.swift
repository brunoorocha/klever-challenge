//
//  CoreDataMyListRepository.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 08/12/23.
//

import Foundation
import CoreData

final class CoreDataMyListRepository {
    private let coreDataManager: CoreDataManager
    
    private var context: NSManagedObjectContext {
        return coreDataManager.persistentContainer.viewContext
    }
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
}

extension CoreDataMyListRepository: MyListRepository {
    func myList() -> [Anime] {
        do {
            let request = NSFetchRequest<CoreDataAnime>(entityName: "CoreDataAnime")
            let dataModels = try context.fetch(request)
            let animes = dataModels.compactMap { dataModel -> Anime? in
                guard let id = dataModel.id,
                      let title = dataModel.title,
                      let status = dataModel.status,
                      let type = dataModel.type
                else { return nil }

                return Anime(
                    id: id,
                    title: title,
                    synopsis: dataModel.synopsis,
                    coverImageURL: dataModel.coverImageURL,
                    posterImageURL: dataModel.posterImageURL,
                    episodeCount: Int(dataModel.episodeCount),
                    status: status,
                    type: type
                )
            }
            return animes
        } catch {
            print(error)
            return []
        }
    }
    
    func add(anime: Anime) {
        let coreDataAnime = CoreDataAnime(context: context)
        coreDataAnime.id = anime.id
        coreDataAnime.title = anime.title
        coreDataAnime.synopsis = anime.synopsis
        coreDataAnime.coverImageURL = anime.coverImageURL
        coreDataAnime.posterImageURL = anime.posterImageURL
        coreDataAnime.episodeCount = Int16(anime.episodeCount ?? 0)
        coreDataAnime.status = anime.status
        coreDataAnime.type = anime.type
        coreDataManager.saveContext()
    }

    func remove(anime: Anime) {
        guard let coreDataAnime = findCoreDataAnime(for: anime) else { return }
        context.delete(coreDataAnime)
    }
    
    func isInMyList(anime: Anime) -> Bool {
        return findCoreDataAnime(for: anime) != nil
    }
    
    private func findCoreDataAnime(for anime: Anime) -> CoreDataAnime? {
        do {
            let request = NSFetchRequest<CoreDataAnime>(entityName: "CoreDataAnime")
            let predicate = NSPredicate(format: "id == %@", anime.id)
            request.predicate = predicate
            return try context.fetch(request).first
        } catch {
            print(error)
            return nil
        }
    }
}
