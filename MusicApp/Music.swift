//
//  Music.swift
//  MusicApp
//
//  Created by Deblina Das on 24/01/18.
//  Copyright © 2018 Deblinas. All rights reserved.
//

import Foundation
import UIKit

struct Music {
    var id: Int!
    var imageUrl: URL?
    var title: String?
    var artistName: String?
    var lengthSize: Double?
    var isPlaying: Bool? = false
}

let titles: [String] = ["Green Day", "The Coast", "Devil's Gun", "Perfectly Chilled", "Sunset chaser", "BLIND", "TROPICO", "THE RESISTANCE", "Coldplay", "KISS", "PHLEARN", "MASTERMIND", "EMINEM RECOVERY", "THINK THANK", "LINKIN PARK"]

let artistsNames: [String] = ["American Idiot", "Shipwreck", "Shipwreck", "Roland Greco", "Yoko Marie", "unknown", "PARADIS", "MUSE", "MUSE", "UNKNOWN", "FT. DJ SWIZZLE STIX", "RICK ROXX", "UNKNOWN", "UNKNOWN", "UNKNOWN"]

let imageURLStrings: [String] = [
"https://www.billboard.com/files/styles/900_wide/public/media/Green-Day-American-Idiot-album-covers-billboard-1000x1000.jpg",
"https://spark.adobe.com/images/landing/examples/design-music-album-cover.jpg",
"https://www.smashingmagazine.com/images/music-cd-covers/43.jpg",
"https://www.designformusic.com/wp-content/uploads/2016/01/perfectly-chilled-album-cover-artwork-design-500x500.jpg",
"https://marketplace.canva.com/MACF48yCzKk/1/0/thumbnail_large/canva-sunset-chaser-album-cover-MACF48yCzKk.jpg",
"https://i.pinimg.com/736x/16/c3/76/16c3766892135064af70cf1b077f2dc9.jpg",
"https://marketplace.canva.com/MAB9YpuFzIs/1/0/thumbnail_large/canva-music-cd-cover-%28album-cover%29-MAB9YpuFzIs.jpg",
"https://4.bp.blogspot.com/-ABhte_JFzcI/UM6m49lkKYI/AAAAAAAADJc/DUIkgMrHmhs/s1600/the_resistance_wallpaper_muse-normal.jpg",
"https://i.pinimg.com/originals/65/55/91/655591e1e8ca1cf23171b726691aabf5.jpg",
"https://cdn.tutsplus.com/psd/uploads/legacy/0612_Typographic_Covers/Kiss_first_album_cover.jpg",
"https://i.ytimg.com/vi/kiZD_JHV_-8/maxresdefault.jpg",
"https://theboombox.com/files/2014/02/RickRoss_Mastermind.jpg",
"https://i.pinimg.com/originals/e4/7b/01/e47b01f57dcae2838199b781b2899c29.jpg",
"https://upload.wikimedia.org/wikipedia/en/d/d1/Think_tank_album_cover.jpg",
"https://i.pinimg.com/originals/50/f4/d5/50f4d510a9c309d587c3108606ae8ac1.jpg"
]
