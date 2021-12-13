import ComposableArchitecture
import SwiftUI

struct TaskListViewState: Equatable {
    var tasks: IdentifiedArrayOf<TaskItemViewState>
    var draftTitle: String
    var isEditing: Bool
}

enum TaskListViewAction {
    case taskItemViewAction(id: UUID, action: TaskItemViewAction)
    case updateDraftTitle(String)
    case toggleEditingMode
    case createTodo
}

struct TaskListViewEnvironment {
    let taskItemViewEnvironment: TaskItemViewEnvironment
    let analyticsClient: AnalyticsClientProtocol
}

let taskListViewReducer = Reducer<TaskListViewState, TaskListViewAction, TaskListViewEnvironment>.combine(
    taskItemViewReducer
        .forEach(
            state: \.tasks,
            action: /TaskListViewAction.taskItemViewAction,
            environment: \.taskItemViewEnvironment
        ),
    Reducer {
    state, action, environment in
    switch action {
    case .toggleEditingMode:
        state.isEditing.toggle()
        environment
            .analyticsClient
            .track(eventName: "toggle_editing_mode", data: [
                "newState": state.isEditing ? "editing" : "not editing"
            ]
            )
        state.tasks = IdentifiedArray(
            uniqueElements: state.tasks.map {
                TaskItemViewState(
                    isEditing: !$0.isEditing,
                    isDone: $0.isDone,
                    title: $0.title,
                    id: $0.id)
            })
    case .updateDraftTitle(let newTitle):
        state.draftTitle = newTitle
    case .taskItemViewAction(let id, action: .delete):
        state.tasks.remove(id: id)
    case .createTodo:
        state.tasks.append(
            TaskItemViewState(
                isEditing: state.isEditing,
                isDone: false,
                title: state.draftTitle,
                id: UUID()
            )
        )
        state.draftTitle = ""
    default:
        break
    }
    return .none
})

struct CATaskListView: View {
    let store: Store<TaskListViewState, TaskListViewAction>
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List {
                    TextField("Enter your todo: ",
                              text: viewStore.binding(
                                get: \.draftTitle,
                                send: TaskListViewAction.updateDraftTitle
                              ),
                              onCommit: { viewStore.send(.createTodo) })
                    ForEachStore(
                        store.scope(state: \.tasks,
                                    action: TaskListViewAction.taskItemViewAction),
                        content: CATaskItemView.init
                    )
                }
                .navigationBarTitle(Text("Tasks"))
                .navigationBarItems(trailing: Button(action: {
                    viewStore.send(.toggleEditingMode)
                }) {
                    viewStore.isEditing ?
                    Text("Done").bold():
                    Text("Edit")
                })
            }
        }
    }
}
