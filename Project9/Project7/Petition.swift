//
//  Petition.swift
//  Project7
//
//  Created by Brian Phillips on 3/6/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import Foundation

struct Petition: Codable {
	var title: String
	var body: String
	var signatureCount: Int
}
