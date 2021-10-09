import ComposableArchitecture
import SwiftUI

struct TaskEditViewState: Equatable {
    var title: String
}

enum TaskEditViewAction {
    case textUpdated(String)
}

struct TaskEditViewEnvironment {}

let taskEditViewReducer = Reducer<TaskEditViewState, TaskEditViewAction, TaskEditViewEnvironment> {
    state, action, environment in
    switch action {
    case .textUpdated(let newTitle):
        state.title = newTitle
    }
    return .none
}

struct CATaskEditView: View {
    let store: Store<TaskEditViewState, TaskEditViewAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                TextField (
                    "Enter New Title...",
                    text: viewStore.binding(get: \.title, send: TaskEditViewAction.textUpdated)
                ).padding()
                Spacer()
            }.navigationBarTitle(Text("Edit Task 📝"))
        }
    }
}
