//
//  LibraryApi.swift
//  RWBlueLibrary
//
//  Created by Pandos on 25.11.2021.
//  Copyright © 2021 Razeware LLC. All rights reserved.
//

import Foundation

final class LibraryApi {
  
  private let persistencyManager = PersistencyMeneger()
  private let httpClient = HTTPClient()
  private let isOnline = false
  
  static let shared = LibraryApi()
  
  private init() {
    
  }
  
  func getAlbums() -> [Album] {
    return persistencyManager.getAlbums()
  }
  
  func addAlbum(_ album: Album, at index: Int) {
    persistencyManager.addAlbum(album, at: index)
    if isOnline {
      httpClient.postRequest("/api/addAlbum", body: album.description)
        }
    }
  
  func deleteAlbum(at index: Int) {
    persistencyManager.deleteAlbum(at: index)
    if isOnline {
      httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
        }
    }
}
  
