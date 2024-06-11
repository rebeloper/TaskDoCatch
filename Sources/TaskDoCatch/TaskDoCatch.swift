
import SwiftUI

public extension View {
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

public func Task(priority: TaskPriority? = nil, do operation: @escaping () async throws -> (), catch: @escaping (Error) -> ()) {
    Task(priority: priority) {
        do {
            try await operation()
        } catch {
            `catch`(error)
        }
    }
}

