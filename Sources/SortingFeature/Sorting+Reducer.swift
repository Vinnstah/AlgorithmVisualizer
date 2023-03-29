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
            
            var listOfAllElementSwaps: [UnsortedElements] = []
            
            state.timer = clock.measure {
                sortingAlgorithms.mergeSort(state.arrayToSort) { swappedElementsList in
                    listOfAllElementSwaps = swappedElementsList
                }
            }
            return .run { [swappedElementsList = listOfAllElementSwaps, animationDelay = state.sortingAnimationDelay] send in
                for swappedValues in swappedElementsList {
                    await send(.internal(.mergeSortValueResponse(swappedValues.values.elements)))
                    try await Task.sleep(for: .milliseconds(animationDelay))
                }
            }
            .animation()
            .cancellable(id: CancelID.sortingAlgorithm)
            
        case let .internal(.mergeSortValueResponse(values)):
            guard values.count != 0 else {
                state.sortingInProgress = false
                return .none
            }
            state.arrayToSort.values = IdentifiedArrayOf(uniqueElements: values)
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
            
            var listOfAllElementSwaps: [UnsortedElements] = []
            
            state.timer = clock.measure {
                sortingAlgorithms.bubbleSort(state.arrayToSort) { swappedElementsList in
                    listOfAllElementSwaps = swappedElementsList
                }
            }
            return .run { [swappedElementsList = listOfAllElementSwaps, animationDelay = state.sortingAnimationDelay] send in
                for swappedValues in swappedElementsList {
                    await send(.internal(.bubbleSortValueResponse(swappedValues.values.elements)))
                    try await Task.sleep(for: .milliseconds(animationDelay))
                }
            }
            .animation()
            .cancellable(id: CancelID.sortingAlgorithm)
            
        case .internal(.selectionSortTapped):
            
            guard !state.arrayToSort.isSorted(order: .increasing) else {
                return .run { send in
                    await send(.internal(.toggleErrorPopover))
                }
            }
            state.sortingInProgress = true
            state.timer = .zero
            
            var listOfAllElementSwaps: [UnsortedElements] = []
            
            state.timer = clock.measure {
                sortingAlgorithms.selectionSort(&state.arrayToSort) { swappedElementsList in
                    listOfAllElementSwaps = swappedElementsList
                }
            }
            
            return .run { [swappedElementsList = listOfAllElementSwaps, animationDelay = state.sortingAnimationDelay] send in
                for swappedValues in swappedElementsList {
                    await send(.internal(.selectionSortValueResponse(swappedValues.values.elements)))
                    try await Task.sleep(for: .milliseconds(animationDelay))
                }
            }
            .animation()
            .cancellable(id: CancelID.sortingAlgorithm)
            
        case .internal(.toggleErrorPopover):
            state.errorPopoverText = "The array is already sorted \n Please reset the array"
            state.errorPopoverIsShowing.toggle()
            return .none
            
        case .view(.resetArrayTapped):
            state.errorPopoverIsShowing = false
            state.sortingInProgress = false
            
            return .merge(
                .cancel(id: CancelID.sortingAlgorithm),
                generate(count: UInt(state.arrayToSort.values.count))
            )
            
        case let .internal(.generateElementsResult(.success(elementsToSort))):
            state.arrayToSort = elementsToSort
            return .none
            
        case .internal(.generateElementsResult(.failure)):
            fatalError()
            
        case let .internal(.bubbleSortValueResponse(values)):
            guard values.count != 0 else {
                state.sortingInProgress = false
                return .none
            }
            state.arrayToSort.values = IdentifiedArrayOf(uniqueElements: values)
            return .none
            
        case let .internal(.selectionSortValueResponse(values)):
            guard values.count != 0 else {
                state.sortingInProgress = false
                return .none
            }
            
            state.arrayToSort.values = IdentifiedArrayOf(uniqueElements: values)
            return .none
            
        case let .view(.animationDelayStepperTapped(value)):
            state.sortingAnimationDelay = value
            return .none
        case .internal(.insertionSortTapped):
            
            guard !state.arrayToSort.isSorted(order: .increasing) else {
                return .run { send in
                    await send(.internal(.toggleErrorPopover))
                }
            }
            
            state.timer = .zero
            state.sortingInProgress = true
            
            var listOfAllElementSwaps: [UnsortedElements] = []
            
            state.timer = clock.measure {
                sortingAlgorithms.insertionSort(&state.arrayToSort) { swappedElementsList in
                    listOfAllElementSwaps = swappedElementsList
                }
            }
            return .run { [swappedElementsList = listOfAllElementSwaps, animationDelay = state.sortingAnimationDelay] send in
                for swappedValues in swappedElementsList {
                    await send(.internal(.insertionSortValueResponse(swappedValues.values.elements)))
                    try await Task.sleep(for: .milliseconds(animationDelay))
                }
            }
            .animation()
            .cancellable(id: CancelID.sortingAlgorithm)
        case let .internal(.insertionSortValueResponse(values)):
            guard values.count != 0 else {
                state.sortingInProgress = false
                return .none
            }
            
            state.arrayToSort.values = IdentifiedArrayOf(uniqueElements: values)
            return .none
        }
    }
    
    private func sleep(delay: Double) -> Effect<Action> {
        return .run { _ in
            try await Task.sleep(for: .milliseconds(delay))
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

private enum CancelID: Hashable {
    case sortingAlgorithm
}
