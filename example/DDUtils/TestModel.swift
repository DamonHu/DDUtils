//
//  TestModel.swift
//  DDUtils
//
//  Created by Damon on 2021/9/3.
//  Copyright © 2021 Damon. All rights reserved.
//

import UIKit

struct TestStruct {
    var cat = "catName"

}

class TestModel: NSObject {
    var age: Int = 20
    var name = "TestModel Name"
    var height: Float = 1.9
    var weight: Double = 70
    var ss = TestModel.self
    var struc = TestStruct()
}

enum TestEnum: CaseIterable {
    case demo1
    case demo2
    case demo3
    case demo4
}
