//
// Copyright (C) 2015 CosmicMind, Inc. <http://cosmicmind.io>.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program located at the root of the software package
// in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
//

import XCTest
@testable import GraphKit

class EntitySearchTests : XCTestCase, GraphDelegate {
	var graph: Graph!
	
	override func setUp() {
		super.setUp()
		graph = Graph()
	}
	
	override func tearDown() {
		graph = nil
		super.tearDown()
	}
	
	func testAll() {
		for n in graph.searchForEntity(types: ["*"]) {
			n.delete()
		}
		
		graph.save { (success: Bool, error: NSError?) in
			XCTAssertTrue(success, "Cannot save the Graph: \(error)")
		}
		
		for var i: Int = 0; i < 100; ++i {
			let n: Entity = Entity(type: "T1")
			n["P1"] = 0 == i % 2 ? "V1" : 1
			n["P2"] = "V2"
			n.addGroup("G1")
			n.addGroup("G2")
		}
		
		for var i: Int = 0; i < 200; ++i {
			let n: Entity = Entity(type: "T2")
			n["P2"] = "V2"
			n.addGroup("G2")
		}
		
		for var i: Int = 0; i < 300; ++i {
			let n: Entity = Entity(type: "T3")
			n["P3"] = "V3"
			n.addGroup("G3")
		}
		
		graph.save { (success: Bool, error: NSError?) in
			XCTAssertTrue(success, "Cannot save the Graph: \(error)")
		}
		
		XCTAssertEqual(0, graph.searchForEntity().count)
		
		XCTAssertEqual(100, graph.searchForEntity(types: ["T1"]).count)
		XCTAssertEqual(300, graph.searchForEntity(types: ["T1", "T2"]).count)
		XCTAssertEqual(600, graph.searchForEntity(types: ["T1", "T2", "T3"]).count)
		XCTAssertEqual(600, graph.searchForEntity(types: ["*"]).count)

		XCTAssertEqual(0, graph.searchForEntity(groups: ["NONE"]).count)
		XCTAssertEqual(100, graph.searchForEntity(groups: ["G1"]).count)
		XCTAssertEqual(300, graph.searchForEntity(groups: ["G1", "G2"]).count)
		XCTAssertEqual(600, graph.searchForEntity(groups: ["G1", "G2", "G3"]).count)
		XCTAssertEqual(600, graph.searchForEntity(groups: ["*"]).count)
		
		XCTAssertEqual(100, graph.searchForEntity(types: ["T1"], groups: ["G1"]).count)
		XCTAssertEqual(300, graph.searchForEntity(types: ["T1"], groups: ["G1", "G2"]).count)
		XCTAssertEqual(600, graph.searchForEntity(types: ["T1"], groups: ["G1", "G2", "G3"]).count)
		XCTAssertEqual(300, graph.searchForEntity(types: ["T1", "T2"], groups: ["G1"]).count)
		XCTAssertEqual(300, graph.searchForEntity(types: ["T1", "T2"], groups: ["G1", "G2"]).count)
		XCTAssertEqual(600, graph.searchForEntity(types: ["T1", "T2"], groups: ["G1", "G2", "G3"]).count)
		XCTAssertEqual(600, graph.searchForEntity(types: ["T1", "T2", "T3"], groups: ["G1"]).count)
		XCTAssertEqual(600, graph.searchForEntity(types: ["T1", "T2", "T3"], groups: ["G1", "G2"]).count)
		XCTAssertEqual(600, graph.searchForEntity(types: ["T1", "T2", "T3"], groups: ["G1", "G2", "G3"]).count)
		XCTAssertEqual(600, graph.searchForEntity(types: ["*"], groups: ["G1"]).count)
		XCTAssertEqual(600, graph.searchForEntity(types: ["*"], groups: ["G1", "G2"]).count)
		XCTAssertEqual(600, graph.searchForEntity(types: ["*"], groups: ["G1", "G2", "G3"]).count)
		
		XCTAssertEqual(100, graph.searchForEntity(properties: [("P1", nil)]).count)
		XCTAssertEqual(50, graph.searchForEntity(properties: [("P1", "V1")]).count)
		XCTAssertEqual(50, graph.searchForEntity(properties: [("P1", 1)]).count)
		XCTAssertEqual(50, graph.searchForEntity(properties: [("*", "V1")]).count)
		XCTAssertEqual(50, graph.searchForEntity(properties: [("*", 1)]).count)
		XCTAssertEqual(100, graph.searchForEntity(properties: [("P1", "V1"), ("P1", 1)]).count)
		XCTAssertEqual(300, graph.searchForEntity(properties: [("P1", nil), ("P2", "V2")]).count)
		XCTAssertEqual(600, graph.searchForEntity(properties: [("P1", nil), ("P2", "V2"), ("P3", "V3")]).count)
		XCTAssertEqual(600, graph.searchForEntity(properties: [("P1", nil), ("P2", nil), ("P3", nil)]).count)
		XCTAssertEqual(600, graph.searchForEntity(properties: [("*", nil)]).count)
		
		XCTAssertEqual(300, graph.searchForEntity(types: ["T1"], properties: [("P1", nil), ("P2", nil)]).count)
		XCTAssertEqual(600, graph.searchForEntity(types: ["T1"], groups: ["G3"], properties: [("P1", nil), ("P2", nil)]).count)
		XCTAssertEqual(600, graph.searchForEntity(types: ["*"], groups: ["*"], properties: [("*", nil)]).count)
		
		for n in graph.searchForEntity(types: ["*"]) {
			n.delete()
		}
		
		graph.save { (success: Bool, error: NSError?) in
			XCTAssertTrue(success, "Cannot save the Graph: \(error)")
		}
	}
	
	func testPerformance() {
		self.measureBlock() {}
	}
}
