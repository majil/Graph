/**
* Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Affero General Public License as published
* by the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Affero General Public License for more details.
*
* You should have received a copy of the GNU Affero General Public License
* along with this program located at the root of the software package
* in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
*
* GKRedBlackNode
*/

internal class GKRedBlackNode<K: Comparable, V>: Comparable, Equatable, Printable {
	internal typealias GKRBNode = GKRedBlackNode<K, V>
	
	internal var parent: GKRBNode!
	internal var left: GKRBNode!
	internal var right: GKRBNode!
	internal var red: Bool
	internal var order: Int
	internal var key: K! = nil
	internal var data: V?
	
	internal var description: String {
		return "{\(key): \(data)}"
	}
	
	internal init() {
		red = false
		order = 0
		data = nil
	}
	
	internal init(parent: GKRBNode, sentinel: GKRBNode, key: K!, data: V?) {
		self.key = key
		self.data = data
		self.parent = parent
		left = sentinel
		right = sentinel
		red = true
		order = 1
	}
}

func == <K: Comparable, V>(lhs: GKRedBlackNode<K, V>, rhs: GKRedBlackNode<K, V>) -> Bool {
	return lhs.key == rhs.key
}

func <= <K: Comparable, V>(lhs: GKRedBlackNode<K, V>, rhs: GKRedBlackNode<K, V>) -> Bool {
	return lhs.key <= rhs.key
}

func >= <K: Comparable, V>(lhs: GKRedBlackNode<K, V>, rhs: GKRedBlackNode<K, V>) -> Bool {
	return lhs.key >= rhs.key
}

func > <K: Comparable, V>(lhs: GKRedBlackNode<K, V>, rhs: GKRedBlackNode<K, V>) -> Bool {
	return lhs.key > rhs.key
}

func < <K: Comparable, V>(lhs: GKRedBlackNode<K, V>, rhs: GKRedBlackNode<K, V>) -> Bool {
	return lhs.key < rhs.key
}
