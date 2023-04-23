//
//  VerbTableViewCell.swift
//  IrregularVerbsAppMVC
//
//  Created by Даниил Павленко on 15.04.2023.
//

import UIKit

final class VerbTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var infinitiveLabel: UILabel!
    @IBOutlet private weak var pastSimpleLabel: UILabel!
    @IBOutlet private weak var participleLabel: UILabel!
    @IBOutlet private weak var translationLabel: UILabel!
    
    // MARK: - Methods
    func configure(for verb: Verb) {
        infinitiveLabel.text = verb.infinitive
        pastSimpleLabel.text = verb.pastSimple
        participleLabel.text = verb.participle
        translationLabel.text = verb.translation
    }
}
