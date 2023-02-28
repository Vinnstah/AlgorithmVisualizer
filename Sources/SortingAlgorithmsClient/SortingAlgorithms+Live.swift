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
            private let algorithmChannel: AsyncThrowingBufferedChannel<[UnsortedElements.Element], Swift.Error> = .init()
            private let replaySubject: AsyncThrowingReplaySubject<[UnsortedElements.Element], Swift.Error> = .init(bufferSize: 1)
            
            private let algorithmChannelBubble: AsyncThrowingBufferedChannel<[Foo]?, Swift.Error> = .init()
            private let replaySubjectBubble: AsyncThrowingReplaySubject<[Foo]?, Swift.Error> = .init(bufferSize: 1)
            
            init() {}
            
            func emit(_ elements: [UnsortedElements.Element]) {
                algorithmChannel.send(elements)
            }
            
            func algorithmAsyncSequence() -> AnyAsyncSequence<[UnsortedElements.Element]> {
                algorithmChannel
                    .multicast(replaySubject)
                    .autoconnect()
                    .eraseToAnyAsyncSequence()
            }
            
            func emitBubbles(_ elements: [Foo]) {
                algorithmChannelBubble.send(elements)
            }
            
            func algorithmAsyncSequenceBubble() -> AnyAsyncSequence<[Foo]?> {
                algorithmChannelBubble
                fatalError()
                    .handleEvents(onCancel: { self.algorithmChannelBubble.finish() })
                    .multicast(replaySubjectBubble)
                    .autoconnect()
                    .eraseToAnyAsyncSequence()
                    
                    
            }
        }
        
        let algorithmHolder = AlgorithmHolder()
        
        return Self(
            mergeSort: { array in
                await merge(array)
            }, mergeSortOutput: {
                await algorithmHolder.algorithmAsyncSequence()
            },
            bubbleSort: { array in
                await bubble(array: array)
            },
            bubbleSortOutput: { array  in
                await bubbleStream(
                    array: array,
                    emitAction: { foo in
                        await algorithmHolder.emitBubbles(foo())
                    }
                )
            },
            bubbleSortReceiver: {
                await algorithmHolder.algorithmAsyncSequenceBubble()
            }
        )
    }
}
