import SwiftUI

@main
struct ca_tutorialApp: App {
    var body: some Scene {
        WindowGroup {
            // TaskListView()
            //     .environmentObject(UserData())
            CATaskListView(
                store:
                        .init(
                            initialState:
                                TaskListViewState(
                                    tasks: .init(),
                                    draftTitle: "",
                                    isEditing: false
                                ),
                            reducer: taskListViewReducer,
                            environment:
                                TaskListViewEnvironment(
                                    taskItemViewEnvironment:
                                        TaskItemViewEnvironment(),
                                    analyticsClient: AnalyticsClient(
                                        firebaseAnalyticsWrapper: FirebaseAnalytics()
                                    )
                                )
                        )
            )
        }
    }
}
