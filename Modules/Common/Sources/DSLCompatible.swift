import Foundation

//TODO: add documantation
@dynamicMemberLookup
public struct DSL<T> {
    
    public let obj: T
    
    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<T, Value>) -> (Value) -> DSL<T> {
        { [obj] value in
            var object = obj
            object[keyPath: keyPath] = value
            return DSL(obj: object)
        }
    }
    
    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<T, Value>) -> (Value) -> T {
        { [obj] value in
            var object = obj
            object[keyPath: keyPath] = value
            return object
        }
    }
}

public protocol DSLCompatible {
    associatedtype DSLType
    var dsl: DSL<DSLType> { get }
}

extension DSLCompatible {
    public var dsl: DSL<Self> {
        DSL(obj: self)
    }
}
