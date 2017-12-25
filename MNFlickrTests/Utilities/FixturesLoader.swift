//
//  FixturesLoader.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 25/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import Foundation

class FixtureLoader: NSObject {
    
    private class func testBundle() -> Bundle {
        return Bundle(for: FixtureLoader.self)
    }
    
    class func loadJSONObjectFromFileNamed(_ fileName : String) -> Data? {
        guard let testBundlePath = testBundle().path(forResource: fileName, ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: testBundlePath)
        return try? Data(contentsOf: url)
    }
}
