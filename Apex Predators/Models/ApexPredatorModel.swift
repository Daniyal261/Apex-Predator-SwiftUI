//
//  ApexPredatorModel.swift
//  Apex Predators
//
//  Created by Raja Adeel Ahmed on 4/5/23.
//

import Foundation
import SwiftUI


struct ApexPredatorModel: Codable, Identifiable {
    let id : Int
    let name: String
    let type: String
    var intro: String = ""
    let movies : [String]
    let movieScenes: [MovieSceneModel]
    let link: String
    
    func typeOverLay() -> Color {
        switch type {
        case "land" : return .brown
        case "sea" : return .blue
        case "air" : return .teal
        default: return .brown
        }
    }
}

struct MovieSceneModel :Codable, Identifiable {
    let id : Int
    let movie: String
    let sceneDescription: String
}
