//
//  TaskEditView.swift
//  SwiftUITodo
//
//  Created by Suyeol Jeon on 03/06/2019.
//  Copyright © 2019 Suyeol Jeon. All rights reserved.
//

import SwiftUI

struct TaskEditView: View {
  @EnvironmentObject var userData: UserData
  private let task: Task
  private var draftTitle: State<String>

  init(task: Task) {
    self.task = task
    self.draftTitle = .init(initialValue: task.title)
  }

  var body: some View {
      VStack(alignment: .leading, spacing: 0) {
      TextField (
        "Enter New Title...",
        text: draftTitle.projectedValue,
        onEditingChanged: { _ in self.updateTask() },
        onCommit: {}
      )
      Spacer()
    }
    .navigationBarTitle(Text("Edit Task 📝"))
  }

  private func updateTask() {
    guard let index = self.userData.tasks.firstIndex(of: self.task) else { return }
      self.userData.tasks[index].title = self.draftTitle.wrappedValue
  }
}
