// MainView.swift
// Handles navigation between EntryView and QuestionsView using NavigationStack and state.
// Apple Design Tips and MVVM/Core-Features structure.

import SwiftUI

enum AppRoute: Hashable {
    case entry
    case questions
    case sessionCompleted
    case results
}

struct MainView: View {
    @State private var path: [AppRoute] = []
    @State private var didFinishOnboarding = false
    @State private var didFinishPremium = false
    
    var body: some View {
        if !didFinishOnboarding {
            OnboardingView {
                didFinishOnboarding = true
            }
        } else if !didFinishPremium {
            PremiumView(
                onUpgrade: { didFinishPremium = true },
                onRestore: { didFinishPremium = true }
            )
        } else {
            NavigationStack(path: $path) {
                EntryView(onStart: {
                    path.append(.questions)
                })
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .questions:
                        QuestionsView(
                            onBack: { if !path.isEmpty { path.removeLast() } },
                            onFinish: { path.append(.sessionCompleted) }
                        )
                    case .sessionCompleted:
                        SessionCompletedView(onSeeResults: {
                            path.append(.results)
                        })
                    case .results:
                        ResultsView(onStartNew: {
                            path = []
                        })
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
} 