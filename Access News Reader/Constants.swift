//
//  Constants.swift
//  Access News Reader
//
//  Created by Society for the Blind on 12/31/17.
//  Copyright © 2017 Society for the Blind. All rights reserved.
//

import Foundation
import UIKit

struct Constants {

    static var documentDir: URL {
        get {
            let documentURLs = FileManager.default.urls(
                for: .documentDirectory,
                in:  .userDomainMask
            )
            return documentURLs.first!
        }
    }

    static var recordings: [URL] {
        get {
            let fileURLs = try? FileManager.default.contentsOfDirectory(at: self.documentDir, includingPropertiesForKeys: nil, options: [])
            return fileURLs ?? []
        }
    }

    // Return URLs in a descending order.
    static var recordingsOrderedByDate: [URL] {
        get {

            func compareValue(_ url: URL) -> Int {
                func getURLDateTime(_ url: URL) -> Date {
                    let urlAttrs = try! FileManager.default.attributesOfItem(atPath: url.path)
                    return urlAttrs[FileAttributeKey.creationDate] as! Date
                }

                // I miss built in function composition.
                return Int(self.dateString(getURLDateTime(url)))!
            }

            return self.recordings.sorted { f,g in
                let fi = compareValue(f)
                let gi = compareValue(g)

                return fi > gi
            }
        }
    }

    static func dateString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"

        return dateFormatter.string(from: date)
    }

    static let userLoggedIn: String = "userLoggedIn"

    // storyboard IDs
    static let  mainViewController = "MainViewController"
    static let loginViewController = "LoginViewController"

    static let noTitleColor =
        UIColor(red:   0.345,
                green: 0.337,
                blue:  0.839,
                alpha: 0.5)

    enum PublicationLabelType {
        case selected, not_selected
    }

    enum MiddleUIPreset: String {
        case listRecordings
        case mainTableViewController
    }
}
