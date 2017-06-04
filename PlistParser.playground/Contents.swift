// (c) 2017 Roman Shevtsov
//
// Put Info.plist from iOS device backup (from ~/Library/Application Support/MobileSync/Backup/...)
// into Resources (on the left pane) and rename it as Backup.plist

import Foundation

/// AppleID -to- PurchaserID bindings
var appleIds: [String: Int] = [:]
/// AppleIDs and list of app names installed with it
var appsById: [String: [String]] = [:]

func plistFrom(data: Data) -> [String: Any]? {
	let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any]
	return plist?.flatMap({ $0 })
}

let plistUrl = Bundle.main.url(forResource: "Backup", withExtension: "plist")!
let plistData = try! Data(contentsOf: plistUrl)

let rootPlist = plistFrom(data: plistData)!

let appsPlist = rootPlist["Applications"] as! [String: Any]

for appPlist in appsPlist {
	let appBundle = appPlist.key

	guard
		let iTunesMetadataData = (appPlist.value as? [String: Any])?["iTunesMetadata"] as? Data,
		let iTunesMetadata = plistFrom(data: iTunesMetadataData),
		let appName = iTunesMetadata["itemName"] as? String,
		let downloadInfo = iTunesMetadata["com.apple.iTunesStore.downloadInfo"] as? [String: Any],
		let accountInfo = downloadInfo["accountInfo"] as? [String: Any],
		let appleID = accountInfo["AppleID"] as? String,
		let purchaserID = accountInfo["PurchaserID"] as? Int
	else {
		continue
	}

	appleIds[appleID] = purchaserID
	var apps: [String] = appsById[appleID] ?? []
	apps.append(appName)
	appsById[appleID] = apps
}

dump(appleIds)
dump(appsById)
