//
//  ProxyNode.swift
//  SpeedX
//
//  Created by ehco on 2021/4/24.
//

import CoreData
import Combine

//NOTE: ProxyNode is a model from Core Data
extension ProxyNode {

	public var id: Int64 {
		get { Int64(id_) }
		set { id_ = Int64(newValue) }
	}

	public var name: String {
		get { name_! }
		set { name_ = newValue }
	}
}
