//
//  MusicXMLParser.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/5/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import Foundation

class MusicXMLParser: NSObject {

    fileprivate var scorePartwise: ScorePartwise!

    fileprivate var lastElementName = ""

    func parse(_ fileName: String) -> ScorePartwise? {
        let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "")
        guard fileUrl != nil else { return nil }

        scorePartwise = ScorePartwise()

        let xmlParser = XMLParser(contentsOf: fileUrl!)!
        xmlParser.delegate = self
        xmlParser.parse()

        return scorePartwise
    }
}

// MARK: - XMLParserDelegate

extension MusicXMLParser: XMLParserDelegate {

    func parser(_ parser: XMLParser, didStartElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String: String] = [:]) {
        print("PARSER: element started \"<\(elementName)>\"")
        if attributeDict.count > 0 {
            print("PARSER: attirbutes \(attributeDict)")
        }
        switch elementName {
        case PartList.xmlTag:
            scorePartwise.partList = PartList()
        case ScorePart.xmlTag:
            scorePartwise.partList.scorePart = ScorePart()
        case PartName.xmlTag:
            scorePartwise.partList.scorePart.partName = PartName()
        case Part.xmlTag:
            scorePartwise.part = Part(from: attributeDict)
        case Measure.xmlTag:
            scorePartwise.part.measure = Measure(from: attributeDict)
        default:
            break
        }

        lastElementName = elementName
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?) {
        print("PARSER: element ended \"</\(elementName)>\"")
        lastElementName = ""
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if string.trim().count > 0 {
            print("PARSER: foundCharacters \"\(string)\"")
        }
        switch lastElementName {
        case PartName.xmlTag:
            scorePartwise.partList.scorePart.partName.partNameText = string
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("error: \(parseError.localizedDescription)")
    }
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
