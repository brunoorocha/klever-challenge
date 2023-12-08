//
//  CoreDataAnime+CoreDataProperties.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 08/12/23.
//
//

import Foundation
import CoreData


extension CoreDataAnime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataAnime> {
        return NSFetchRequest<CoreDataAnime>(entityName: "CoreDataAnime")
    }

    @NSManaged public var coverImageURL: String?
    @NSManaged public var episodeCount: Int16
    @NSManaged public var id: String?
    @NSManaged public var posterImageURL: String?
    @NSManaged public var status: String?
    @NSManaged public var synopsis: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?

}

extension CoreDataAnime : Identifiable {

}
