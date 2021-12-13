import ComposableArchitecture
import SwiftUI

public struct TaskEditViewState: Equatable {
    public init(title: String) {
        self.title = title
    }

    public var title: String
}

public enum TaskEditViewAction {
    case textUpdated(String)
}

public struct TaskEditViewEnvironment {}

public let taskEditViewReducer = Reducer<TaskEditViewState, TaskEditViewAction, TaskEditViewEnvironment> {
    state, action, environment in
    switch action {
    case .textUpdated(let newTitle):
        state.title = newTitle
    }
    return .none
}

public struct CATaskEditView: View {
    public init(store: Store<TaskEditViewState, TaskEditViewAction>) {
        self.store = store
    }

    let store: Store<TaskEditViewState, TaskEditViewAction>

    public var body: some View {
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


struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        CATaskEditView(store: .init(
            initialState: .init(title: "Get Groceries"),
            reducer: taskEditViewReducer,
            environment: TaskEditViewEnvironment())
        )
    }
}

