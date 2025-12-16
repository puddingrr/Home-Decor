//
//  LoginModel.swift
//  LMS-iOS
//
//  Created by Brilliant Dev on 5/2/25.
//

import Foundation

struct LoginDataModel: Codable {
    let id: Int?
    let email: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case createdAt = "created_at"
    }
}
