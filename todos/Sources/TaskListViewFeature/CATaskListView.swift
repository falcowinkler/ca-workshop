import ComposableArchitecture
import SwiftUI
import Analytics
import TaskEditViewFeature

public struct TaskListViewState: Equatable {
    public init(tasks: IdentifiedArrayOf<TaskItemViewState>, draftTitle: String, isEditing: Bool) {
        self.tasks = tasks
        self.draftTitle = draftTitle
        self.isEditing = isEditing
    }

    public var tasks: IdentifiedArrayOf<TaskItemViewState>
    public var draftTitle: String
    public var isEditing: Bool
}

public enum TaskListViewAction {
    case taskItemViewAction(id: UUID, action: TaskItemViewAction)
    case updateDraftTitle(String)
    case toggleEditingMode
    case createTodo
}

public struct TaskListViewEnvironment {
    public init(taskItemViewEnvironment: TaskItemViewEnvironment, analyticsClient: AnalyticsClientProtocol) {
        self.taskItemViewEnvironment = taskItemViewEnvironment
        self.analyticsClient = analyticsClient
    }

    public let taskItemViewEnvironment: TaskItemViewEnvironment
    public let analyticsClient: AnalyticsClientProtocol
}

public let taskListViewReducer = Reducer<TaskListViewState, TaskListViewAction, TaskListViewEnvironment>.combine(
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

public struct CATaskListView: View {
    public init(store: Store<TaskListViewState, TaskListViewAction>) {
        self.store = store
    }

    let store: Store<TaskListViewState, TaskListViewAction>
    public var body: some View {
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

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        CATaskListView(store: .init(
            initialState: .init(tasks: IdentifiedArrayOf([
                .init(
                    isEditing: true,
                    isDone: false,
                    title: "get groceries",
                    id: UUID()
                )
            ]), draftTitle: "get groceries",
                                isEditing: false),
            reducer: taskListViewReducer,
            environment: TaskListViewEnvironment(
                taskItemViewEnvironment: TaskItemViewEnvironment(), analyticsClient: NoopAnalyticsClient()
            ))
        )
    }
}

