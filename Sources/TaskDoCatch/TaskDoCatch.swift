
import SwiftUI

public extension View {
    /// Adds an asynchronous task to perform inside a do catch before this view appears.
    /// - Parameters:
    ///   - priority: The task priority to use when creating the asynchronous
    ///     task. The default priority is
    ///     <doc://com.apple.documentation/documentation/Swift/TaskPriority/userInitiated>.
    ///   - action: A closure that SwiftUI calls as an asynchronous task
    ///     before the view appears. SwiftUI will automatically cancel the task
    ///     at some point after the view disappears before the action completes.
    ///   - catch: Catches the Error
    ///
    ///
    /// - Returns: A view that runs the specified action asynchronously before
    ///   the view appears.
    func task(priority: TaskPriority = .userInitiated, do action: @escaping () async throws -> (), catch: @escaping (Error) -> ()) -> some View {
        self.task(priority: priority) {
            do {
                try await action()
            } catch {
                `catch`(error)
            }
        }
    }
}

/// Runs the given operation asynchronously inside a do catch
/// as part of a new top-level task on behalf of the current actor.
///
/// - Parameters:
///   - priority: The priority of the task.
///     Pass `nil` to use the priority from `Task.currentPriority`.
///   - operation: The operation to perform.
///   - catch: Catches the Error
public func Task(priority: TaskPriority? = nil, do operation: @escaping () async throws -> (), catch: @escaping (Error) -> ()) {
    Task(priority: priority) {
        do {
            try await operation()
        } catch {
            `catch`(error)
        }
    }
}

