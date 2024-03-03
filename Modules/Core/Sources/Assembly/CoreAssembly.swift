import Swinject


public let CoreContainer: Container = {
    let c = Container(defaultObjectScope: .graph)
    return c
}()
