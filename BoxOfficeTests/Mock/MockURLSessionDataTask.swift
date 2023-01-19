//
//  MockURLSessionDataTask.swift
//  BoxOfficeTests
//
//  Created by john-lim on 2023/01/19.
//

import Foundation
import UIKit

class MockURLSessionDataTask: URLSessionDataTask {

    private let resumeHandler: () -> Void
    
    init(resumeHandler: @escaping () -> Void) {
        self.resumeHandler = resumeHandler
    }
    
    override func resume() {
        resumeHandler()
    }
}
