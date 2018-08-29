//
//  FileManagerClass.swift
//  PhoneBook3
//
//  Created by Vova on 8/29/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import Foundation

final class FileManagerClass {
    
    private let fileManager = FileManager.default
    private var documentDirectory : URL? {
        get {
            guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return nil
            }
            print(documentDirectory) //MARK: debug!
            return documentDirectory
            }
        }
    private var contactDirectory : URL? {
        get {
            guard let documentDirectory = documentDirectory else {
                return nil
            }
            print("doc:", documentDirectory)
            return documentDirectory.appendingPathComponent("Contacts", isDirectory: true)
        }
    }
        
    private var plistFile : URL? {
        get {
            guard let contactDirectory = contactDirectory else { return nil }
            return contactDirectory.appendingPathComponent("\(Date()).plist")
        }
    }
    
    func createContactDirectory() throws {
        do {
            guard let contactDirectory = contactDirectory else { return }
            print("path", contactDirectory)
            try fileManager.createDirectory(at: contactDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            throw ErrorToThrow.failToCreateFile
        }
    }
    
//    func createImagesFolder() throws {
//        do {
//            guard let documentDirectory = documentDirectory else { return }
//            try fileManager.createDirectory(at: URL(fileURLWithPath: documentDirectory.appending("/Images")), withIntermediateDirectories: true, attributes: nil)
//        } catch {
//            throw ErrorToThrow.failToCreateFile
//        }
//    }
    
    func removeFile(from : String) throws {
        do {
            try fileManager.removeItem(atPath: from)
        } catch {
            throw ErrorToThrow.failToDeleteFile
        }
    }
    
//    func readDataFromPlist() throws {
//        print("READING from plist")
//        var readContact = Contact()
//        do {
//            if let plist = plistFile {
//                let data = try Data(contentsOf: plist)
//                let decoder = PropertyListDecoder()
//                readContact = try decoder.decode(Contact.self, from: data)
//                print("Contact:", readContact.name, readContact.surname)
//                //contacts.append(readContact)
//            } else {
//                print("no plist files")
//            }
//        } catch {
//            throw ErrorToThrow.failToReadFromPlist
//        }
//    }
    
    func writeDataToPlist() throws {
        print("WRITING to plist")
        let writeContact = Contact(name: "dwwwd", surname: "ww")
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(writeContact)
            if let plist = plistFile {
            try data.write(to: plist)
            }
        } catch {
            throw ErrorToThrow.failWriteToPlist
        }
    }
}
