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

    fileprivate var lastMeasure: Measure!

    fileprivate var lastNote: Note!

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
            lastMeasure = Measure(from: attributeDict)
            scorePartwise.part.measures.append(lastMeasure)
        case Attributes.xmlTag:
            lastMeasure.attributes = Attributes()
        case Key.xmlTag:
            lastMeasure.attributes?.key = Key()
        case Time.xmlTag:
            lastMeasure.attributes?.time = Time()
        case Clef.xmlTag:
            lastMeasure.attributes?.clef = Clef()
        case Note.xmlTag:
            lastNote = Note()
            lastMeasure.notes.append(lastNote)
        case Pitch.xmlTag:
            lastNote.pitch = Pitch()
        default:
            break
        }

        lastElementName = elementName
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?) {
        lastElementName = ""
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch lastElementName {
        case PartName.xmlTag:
            scorePartwise.partList.scorePart.partName.partNameText = string
        case Attributes.xmlDivisionsTag:
            lastMeasure.attributes?.divisions = Int(string)
        case Attributes.xmlFifthsTag:
            lastMeasure.attributes?.key.fifths = Int(string)
        case Time.xmlBeatsTag:
            lastMeasure.attributes?.time.beats = string
        case Time.xmlBeatTypeTag:
            lastMeasure.attributes?.time.beatType = string
        case Clef.xmlSignTag:
            lastMeasure.attributes?.clef?.sign = Clef.Sign(rawValue: string)
        case Clef.xmlLineTag:
            lastMeasure.attributes?.clef?.line = Int(string)
        case Note.xmlDurationTag:
            lastNote.duration = UInt(string)
        case Note.xmlVoiceTag:
            lastNote.voice = string
        case Note.xmlTypeTag:
            lastNote.type = NoteType(rawValue: string)
        case Pitch.xmlStepTag:
            lastNote.pitch.step = Step(rawValue: string)
        case Pitch.xmlOctaveTag:
            lastNote.pitch.octave = UInt(string)
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
