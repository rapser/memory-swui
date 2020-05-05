//
//  MemoryViewController.swift
//  memory-swui
//
//  Created by miguel tomairo on 5/4/20.
//  Copyright © 2020 rapser. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var item: MemoryItem!
    var blankCounter = 0
    
    let visibleText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)! ,
        .foregroundColor: UIColor.black
    ]
    
    let invisibleText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)!,
        .foregroundColor: UIColor.clear,
        .strikethroughStyle: 1,
        .strikethroughColor: UIColor.black
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(item != nil, "Deberias proveer un memory item antes de intentar mostrar este view controller")
        textView.attributedText = showText(for: item)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(wordsTapped))
        textView.addGestureRecognizer(tapRecognizer)
    }

    func showText(for memoryItem: MemoryItem) -> NSAttributedString {
        
        let words = memoryItem.text.components(separatedBy: " ")
        let output = NSMutableAttributedString()
        
        let space = NSAttributedString(string: " ", attributes: visibleText)
        
        for (index, word) in words.enumerated() {
            if index < blankCounter {
//                output += "\(word) "
                let attributeWord = NSAttributedString(string: word, attributes: visibleText)
                output.append(attributeWord)
            } else {
                
                var strippedWord = word
                var punctuation: String?
                
                if ".,".contains(word.last!) {
                    punctuation = String(strippedWord.removeLast())
                }
                
                let attributeWord = NSAttributedString(string: strippedWord, attributes: invisibleText)
                output.append(attributeWord)
                
                if let symbol = punctuation {
                    let attributedPunctutation = NSAttributedString(string: symbol, attributes: visibleText)
                    output.append(attributedPunctutation)
                }
//                let blank = String(repeating: "_", count: word.count)
//                output += "\(blank) "
            }
            output.append(space)
        }
        
        return output
    }

    @objc func wordsTapped() {
        blankCounter += 1
        textView.attributedText = showText(for: item)
    }
}
