//
//  Destination.swift
//  SwiftDataPractice
//
//  Created by Ray on 2024/11/6.
//

import Foundation
import SwiftData

// Reference = https://youtu.be/kiFQevfpuKQ?si=gA08MmF3QHOpgdPd
@Model
class Destination {
  var name: String
  var details: String
  var date: Date
  var priority: Int
  
  // Relationships
  // 使用建議：
  // .cascade 適用於：父子關係強烈相依,子項目沒有父項目就沒有意義的情況,例如：部門與員工、文章與評論
  // .nullify 適用於：關聯是可選的,物件可以獨立存在,例如：書籍與作者、學生與選修課程
  // .deny 適用於：需要強制確保關聯完整性,防止意外刪除重要資料,例如：必修課程與學生
  // .noAction 適用於：需要手動處理關聯,複雜的刪除邏輯,例如：專案管理系統中的任務分配
  @Relationship(deleteRule: .cascade) var sights: [Sight] = []

  init(
    name: String = "", details: String = "", date: Date = .now,
    priority: Int = 2
  ) {
    self.name = name
    self.details = details
    self.date = date
    self.priority = priority
  }
}
