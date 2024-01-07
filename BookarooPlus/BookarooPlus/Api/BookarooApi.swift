//
//  BookarooApiProtocol.swift
//  BookarooPlus
//
//  Created by Patrik Michl on 04.01.2024.
//

import Foundation

class BookarooApi : Api {
    let token = UserDefaults.standard.string(forKey: DefaultsKey.token.rawValue)
    let baseUrl: String = BaseUrls.bookaroo.rawValue
}
