import ComposableArchitecture
import Foundation
import UnsortedElements

public extension Sorting {
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
        switch action {
        case let .view(.arraySizeStepperTapped(count)):
            return generate(count: count)
            
        case let .internal(.sortingTimer(time, type)):
            state.timer = time
            state.historicalSortingTimes.addTime(time: state.timer, type: type)
            return .none
            
        case .internal(.mergeSortTapped):
            
            guard !state.arrayToSort.isSorted(order: .increasing) else {
                return .run { send in
                    await send(.internal(.toggleErrorPopover))
                }
            }
            
            state.timer = .zero
            state.sortingInProgress = true
            return .run { [unsortedArray = state.arrayToSort] send in
                await send(.internal(.sortingTimer(
                    await self.clock.measure {
                        //                        await send(.internal(.mergeSortResult(TaskResult {
                        //                            await sortingAlgorithms.mergeSort(unsortedArray)
                        await sortingAlgorithms.mergeSort(unsortedArray)
                    },
                    .merge
                )))
            }
            .animation()
            
        case let .internal(.mergeSortValueResponse(value)):
            print("VALUES \(value)")
            //            state.arrayToSort.values.
            state.sortingInProgress = false
            return .none
            
            
        case .internal(.onAppear):
            return generate(count: State.defaultElementCount)
            
        case .internal(.bubbleSortTapped):
            
            guard !state.arrayToSort.isSorted(order: .increasing) else {
                return .run { send in
                    await send(.internal(.toggleErrorPopover))
                }
            }
            state.sortingInProgress = true
            state.timer = .zero
            return .run { [unsortedArray = state.arrayToSort] send in
                await send(.internal(.sortingTimer(
                    await self.clock.measure {
                        await self.sortingAlgorithms.bubbleSort(unsortedArray)
                    },
                    .bubble
                )
                )
                )
            }
            .animation()
            
        case .internal(.toggleErrorPopover):
            state.errorPopoverText = "The array is already sorted \n Please reset the array"
            state.errorPopoverIsShowing.toggle()
            return .none
            
        case .view(.resetArrayTapped):
            state.errorPopoverIsShowing = false
            state.sortingInProgress = false
            return generate(count: UInt(state.arrayToSort.values.count))
            
        case let .internal(.generateElementsResult(.success(elementsToSort))):
            state.arrayToSort = elementsToSort
            return .none
            
        case .internal(.generateElementsResult(.failure)):
            fatalError()
            
        case .task:
            return .run { send in
                await  withThrowingTaskGroup(of: Void.self) { group in
                    group.addTask {
                        for try await value in await sortingAlgorithms.bubbleSortReceiver() {
                            guard let value else {
                                return
                            }
                            await send(.internal(.bubbleSortValueResponse(value)), animation: .easeInOut)
                        }
                    }
                    group.addTask {
                        for try await value in await sortingAlgorithms.mergeSortReceiver() {
                            guard let value else {
                                return
                            }
                            await send(.internal(.mergeSortValueResponse(value)), animation: .easeInOut)
                        }
                    }
                }
            }
            
        case let .internal(.bubbleSortValueResponse(value)):
            guard value != [] else {
                state.sortingInProgress = false
                return .none
            }
            
            state.arrayToSort.values.swapAt(value[0].previousIndex!, value[1].previousIndex!)
            return .run { [sortingDelay = state.sortingAnimationDelay] _ in
                try await Task.sleep(for: .milliseconds(sortingDelay))
            }
            
        case let .view(.animationDelayStepperTapped(value)):
            state.sortingAnimationDelay = value
            return .none
        }
    }
    
    private func sleep(delay: Double) -> Effect<Action> {
        return .run { _ in
            try await Task.sleep(for: .milliseconds(delay))
            //                            try await clock.sleep(for: .milliseconds(delay))
        }
    }
    
    private func generate(count: UInt) -> Effect<Action> {
        return .run { send in
            await send(.internal(.generateElementsResult(
                TaskResult {
                    await elementGenerator.generate(count)
                }
            )))
        }
    }
}

public enum CancellationID: Hashable {}
