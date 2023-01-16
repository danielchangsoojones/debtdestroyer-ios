//
//  VideoAnswer.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 1/9/23.
//

import Foundation
import Parse

class VideoAnswerParse: SuperParseObject, PFSubclassing {
    @NSManaged var video_url_string: String

    class func parseClassName() -> String {
        return "VideoAnswer"
    }
}
