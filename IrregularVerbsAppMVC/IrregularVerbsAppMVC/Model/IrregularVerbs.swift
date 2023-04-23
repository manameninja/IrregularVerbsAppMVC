//
//  IrregularVerbs.swift
//  IrregularVerbsAppMVC
//
//  Created by Даниил Павленко on 15.04.2023.
//

import Foundation

class IrregularVerbs {
    private(set) var verbs: [Verb] = []
    var selectVerbs: [Verb] = []
    
    func configureVerbs() {
        verbs = [
            Verb(infinitive: "blow", pastSimple: "blew", participle: "blown"),
            Verb(infinitive: "draw", pastSimple: "drew", participle: "drawn"),
            Verb(infinitive: "eat", pastSimple: "ate", participle: "eaten"),
            Verb(infinitive: "fall", pastSimple: "fell", participle: "fallen"),
        ]
    }
}
