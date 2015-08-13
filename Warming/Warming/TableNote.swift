//
//  TableNote.swift
//  Warming
//
//  Created by ZhongGarry on 15/8/10.
//  Copyright (c) 2015年 ZhongGarry. All rights reserved.
//

import SQLite

struct NoteEntity {
    var noteId: Int64?
    let title: String
    let content: String
    let repeatType: WarmingRepeatType
    let isWarmingOn: Bool
    let warmingDate: NSDate?
    let createAt: NSDate
    let updateAt: NSDate
}

class TableNote: NSObject {
    private static let shareInstance = TableNote()
    private static let note = DBExecutor.db["note"]
    private static let noteId = Expression<Int64>("noteId")
    private static let title = Expression<String>("title")
    private static let content = Expression<String>("content")
    private static let repeatType = Expression<Int>("repeatType")
    private static let isWarmingOn = Expression<Bool>("isWarmingOn")
    private static let warmingDate = Expression<NSDate?>("warmingDate")
    private static let createAt = Expression<NSDate>("create")
    private static let updateAt = Expression<NSDate>("updateAt")
    
    class func createTableIfNoeExist() {
        DBExecutor.createTableIfNotExistWithTable(note) { table in
            table.column(self.noteId, primaryKey: true)
            table.column(self.title)
            table.column(self.content)
            table.column(self.repeatType)
            table.column(self.isWarmingOn)
            table.column(self.warmingDate)
            table.column(self.createAt)
            table.column(self.updateAt)
        }
    }

    class func insertOrReplaceWithEntity(entity: NoteEntity) {
        var values = [
            title <- entity.title,
            content <- entity.content,
            repeatType <- entity.repeatType.rawValue,
            isWarmingOn <- entity.isWarmingOn,
            warmingDate <- entity.warmingDate,
            createAt <- entity.createAt,
            updateAt <- entity.updateAt
        ]
        if entity.noteId != nil {
            values.append(noteId <- entity.noteId!)
        }
        DBExecutor.insertOrReplaceWithTable(note, values: values)
    }
    class func test() {
        let entity = NoteEntity(noteId: 4, title: "titile1", content: "content", repeatType: .Once, isWarmingOn: true, warmingDate: nil, createAt: NSDate(), updateAt: NSDate())
        insertOrReplaceWithEntity(entity)
        
    }
}
