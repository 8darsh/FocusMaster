//
//  TaskModel.swift
//  FocusMaster
//
//  Created by Adarsh Singh on 20/05/24.
//

import Foundation
import SwiftData

@Model
final class TaskModel: Identifiable{
    
    @Attribute(.unique) var id: String = UUID().uuidString
    var title: String
    var descript: String
    var deadline: Date
    
    init(title: String, descript: String, deadline: Date)  {
        self.title = title
        self.descript = descript
        self.deadline = deadline
    }
}
