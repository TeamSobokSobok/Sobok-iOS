//
//  APIConstants.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/18.
//

import Foundation

import Alamofire

enum NetworkHeaderKey: String {
    case accessToken = "accesstoken"
    case contentType = "Content-Type"
}

enum APIConstants {
    static let authorization = "Authorization"
    static let accept = "Accept"
    static let auth = "x-auth-token"
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    
    static let accessToken23: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjIsImVtYWlsIjoiZWRAZ21haWwuY29tIiwibmFtZSI6bnVsbCwiaWRGaXJlYmFzZSI6InVOR2llMWxKWDNTREpTQnFSWHhLZUhqMnJhMzMiLCJpYXQiOjE2NDE4ODYzNjUsImV4cCI6MTY0NDQ3ODM2NSwiaXNzIjoid2Vzb3B0In0.K9xOhsd1G3sHAo89LRbLHaPySX8PeOW3kxvbbYaVeNA"
    static let accessToken24: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjQsImVtYWlsIjoiYmJkQGdtYWlsLmNvbSIsIm5hbWUiOm51bGwsImlkRmlyZWJhc2UiOiJaNVRBM2VWaFVwZHdCV2hHdEpiOVJsWkZMM3YyIiwiaWF0IjoxNjQxODkzNjc1LCJleHAiOjE2NDQ0ODU2NzUsImlzcyI6Indlc29wdCJ9.Qc20TVDA2ptT8SClPC6TsCeFK8_3wQX0RISunGCX90k"
    static let accessToken26: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjYsImVtYWlsIjoidGVzdEBnbWFpbC5jb20iLCJuYW1lIjpudWxsLCJpZEZpcmViYXNlIjoiTnBRVmhYdUg3eVUwUkpVdUV6Zks3NldWckFGMiIsImlhdCI6MTY0MjA5MjkwMiwiZXhwIjoxNjQ0Njg0OTAyLCJpc3MiOiJ3ZXNvcHQifQ.fZ4bodbWJ3AlgD_c0oE5OyAW2WaXDeQHtApZLaZjdGI"
    static let accessToken27: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoic29ib2tAZ21haWwuY29tIiwibmFtZSI6bnVsbCwiaWRGaXJlYmFzZSI6Im52NzdlS0Z3T1FURU0zTVRvcUlNbW9QQlR6bDEiLCJpYXQiOjE2NDIwOTMxMDcsImV4cCI6MTY0NDY4NTEwNywiaXNzIjoid2Vzb3B0In0.eXLGkqQlrEqlWZCvMdJCtaTRNUCOwg7vT6clQkD6NZ4"
    
    static var header: [String: String] {
        [NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON]
    }
    
    static var headerWithToken: [String: String] {
        [
            NetworkHeaderKey.contentType.rawValue: APIConstants.applicationJSON,
            NetworkHeaderKey.accessToken.rawValue: APIConstants.accessToken23
        ]
    }
}
