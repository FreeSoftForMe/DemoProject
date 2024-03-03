//
//  Command.swift
//  Common
//
//  Created by Dmitrii on 3/3/24.
//

import Foundation

//TODO: Add documentation, wrapper to Command<Void>
public final class Command<T>: Hashable {
    private let id: UUID = .init()
    private let line: UInt
    private let file: String
    private let action: (T) -> ()
    
    public init(line: UInt = #line,
                file: StaticString = #file,
                action: @escaping (T) -> Void) {
        self.line = line
        self.file = String(describing: file)
        self.action = action
    }
    
    public static var empty: Command<T> {
        .init(action: { _ in} )
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(line)
        hasher.combine(file)
    }
    
    public static func == (lhs: Command<T>, rhs: Command<T>) -> Bool {
        lhs.id == rhs.id &&
        lhs.line == rhs.line &&
        lhs.file == rhs.file
    }
    
    public func callAsFunction(_ value: T) {
        DispatchQueue.main.async {
            self.action(value)
        }
    }
}

public extension Command where T == Void {
    func callAsFunction() {
        DispatchQueue.main.async {
            self.action(())
        }
    }
}
