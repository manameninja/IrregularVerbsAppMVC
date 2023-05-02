//
//  IrregularVerbs.swift
//  IrregularVerbsAppMVC
//
//  Created by Даниил Павленко on 15.04.2023.
//

import Foundation

final class IrregularVerbs {
    //Singleton
    static var shared = IrregularVerbs()
    private init() {
        configureVerbs()
    }
    
    // MARK: - Properties
    private(set) var verbs: [Verb] = []
    var selectVerbs: [Verb] = []
    
    private func configureVerbs() {
        verbs = [
            Verb(infinitive: "blow", pastSimple: "blew", participle: "blown"),
            Verb(infinitive: "draw", pastSimple: "drew", participle: "drawn"),
            Verb(infinitive: "eat", pastSimple: "ate", participle: "eaten"),
            Verb(infinitive: "fall", pastSimple: "fell", participle: "fallen"),
        ]
    }
}
