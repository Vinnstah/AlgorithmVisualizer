import ComposableArchitecture
import Foundation
import UnsortedElements
import AsyncExtensions

extension SortingAlgorithms: DependencyKey {
    public static var liveValue: SortingAlgorithms {
        actor AlgorithmHolder: Sendable {
            
            // uses `AsyncBufferedChannel` from: https://github.com/sideeffect-io/AsyncExtensions
            // MUST have this if you PRODUCE values in one Task and CONSUME values in another,
            // which one very very often would like to do. AsyncStream DOES NOT support this.
            
            private let algorithmChannel: AsyncThrowingBufferedChannel<[UnsortedElements.Element]?, Swift.Error> = .init()
            private let algorithmChannelQueue: AsyncThrowingBufferedChannel<Queue<UnsortedElements.Element>?, Swift.Error> = .init()
            private let algorithmChannelGeneric: AsyncThrowingBufferedChannel<[UnsortedElements.Element]?, Swift.Error> = .init()
            private let replaySubject: AsyncThrowingReplaySubject<[UnsortedElements.Element]?, Swift.Error> = .init(bufferSize: 1)
            private let replaySubjectQueue: AsyncThrowingReplaySubject<Queue<UnsortedElements.Element>?, Swift.Error> = .init(bufferSize: 1)
            
            init() {}
            
            func emit(_ elements: UnsortedElements)  {
                algorithmChannel.send(elements.values.elements)
            }

            
            func algorithmAsyncSequenceQueue() -> AnyAsyncSequence<Queue<UnsortedElements.Element>?> {
                algorithmChannelQueue
                    .multicast(replaySubjectQueue)
                    .autoconnect()
                    .eraseToAnyAsyncSequence()
            }
            
            func algorithmAsyncSequence() -> AnyAsyncSequence<[UnsortedElements.Element]?> {
                algorithmChannel
                    .multicast(replaySubject)
                    .autoconnect()
                    .eraseToAnyAsyncSequence()
            }
        }
        
        let algorithmHolder = AlgorithmHolder()
        
        return Self(
            mergeSort: { arrayToSort in
                await algorithmHolder.emit(await _merge(array: arrayToSort) { elementsToSort in
//                    await algorithmHolder.emit(elementsToSort)
                }
                )
                return
            }, mergeSortReceiver: {
                await algorithmHolder.algorithmAsyncSequence()
            },
            bubbleSort: { arrayToSort in
                await _bubbleSort(arrayToSort) { swappedPairs in
                    await algorithmHolder.emit(swappedPairs)
                }
            },
            bubbleSortReceiver: {
                await algorithmHolder.algorithmAsyncSequence()
            },
            selectionSort: { array in
                var arrayToSort = array
                await _selectionSort(&arrayToSort, 0) { elementsToSort in
                    await algorithmHolder.emit(elementsToSort)
                }
            }
        )
    }
}
