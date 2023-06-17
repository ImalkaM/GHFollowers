//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-06-17.
//

import Foundation

enum GFErrorMessage: String, Error {
    case invalidUsername = "This username created an invaluid request, Please try again."
    case unableToComplete = "unable to complete your request, Please check your internet connection."
    case invalidResponse = "Invalid response from the server, Please try again"
    case invalidData = "The data received from the server was invalid,Please try again."
}
