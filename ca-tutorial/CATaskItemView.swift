import ComposableArchitecture
import SwiftUI
import TaskEditViewFeature

public struct TaskItemViewState: Equatable, Identifiable {
    public init(isEditing: Bool, isDone: Bool, title: String, id: UUID) {
        self.isEditing = isEditing
        self.isDone = isDone
        self.title = title
        self.id = id
    }

    public var isEditing: Bool
    public var isDone: Bool
    public var title: String
    public let id: UUID
}

public enum TaskItemViewAction {
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
