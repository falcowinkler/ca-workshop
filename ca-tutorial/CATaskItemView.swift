import ComposableArchitecture
import SwiftUI

struct TaskItemViewState: Equatable, Identifiable {
    var isEditing: Bool
    var isDone: Bool
    var title: String
    let id: UUID
}

enum TaskItemViewAction {
    case toggleDone
    case taskEditViewAction(TaskEditViewAction)
    case delete
}

struct TaskItemViewEnvironment {}

let taskItemViewReducer = Reducer<TaskItemViewState, TaskItemViewAction, TaskItemViewEnvironment> {
    state, action, environment in
    switch action {
    case .toggleDone:
        state.isDone.toggle()
    case .taskEditViewAction(.textUpdated(let newTitle)):
        state.title = newTitle
    default:
        break
    }
    return .none
}

struct CATaskItemView: View {
    let store: Store<TaskItemViewState, TaskItemViewAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                if viewStore.isEditing {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.red)
                        .onTapGesture {
                            viewStore.send(.delete)
                        }
                    NavigationLink(
                        destination: CATaskEditView(store: self.store.scope(
                            state: {
                                TaskEditViewState(title: $0.title)
                            }, action: TaskItemViewAction.taskEditViewAction))) {
                                Text(viewStore.title)
                            }
                } else {
                    Button(action: { viewStore.send(.toggleDone) }) {
                        Text(viewStore.title)
                    }
                    Spacer()
                    if viewStore.isDone {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                    }
                }
            }
        }
    }
}
