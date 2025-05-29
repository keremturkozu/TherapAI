// OnboardingView.swift
// Modern, motivating, and marketing-focused 5-page onboarding for TherapAI.
// Each page: big icon, title, description, progress dots, navigation buttons.

import SwiftUI

struct OnboardingPage {
    let icon: String
    let title: String
    let description: String
    let iconColor: Color
}

let onboardingPages: [OnboardingPage] = [
    OnboardingPage(
        icon: "sparkles",
        title: "Welcome to TherapAI",
        description: "Your personal AI-powered therapy companion.",
        iconColor: Color(hex: "#A18CD1")
    ),
    OnboardingPage(
        icon: "lock.shield",
        title: "Private & Secure",
        description: "Your answers are 100% private. Only you can see them.",
        iconColor: Color(hex: "#9575CD")
    ),
    OnboardingPage(
        icon: "person.crop.circle.badge.checkmark",
        title: "Personalized Sessions",
        description: "Every session is tailored to your needs and feelings.",
        iconColor: Color(hex: "#7E57C2")
    ),
    OnboardingPage(
        icon: "brain.head.profile",
        title: "AI-Powered Insights",
        description: "Get meaningful insights and actionable suggestions, powered by AI.",
        iconColor: Color(hex: "#4A148C")
    ),
    OnboardingPage(
        icon: "heart.circle.fill",
        title: "Start Your Journey",
        description: "Ready to discover yourself? Let's begin your first session!",
        iconColor: Color(hex: "#F06292")
    )
]

struct OnboardingView: View {
    @State private var currentPage: Int = 0
    var onFinish: (() -> Void)? = nil
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#EDE7F6"), Color(hex: "#B3C6E6")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()
                Image(systemName: onboardingPages[currentPage].icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(onboardingPages[currentPage].iconColor)
                    .shadow(radius: 10)
                    .padding(.bottom, 8)

                Text(onboardingPages[currentPage].title)
                    .font(.title.bold())
                    .foregroundColor(Color(hex: "#4A148C"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                Text(onboardingPages[currentPage].description)
                    .font(.body)
                    .foregroundColor(Color(hex: "#4A148C").opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer()

                // Progress dots
                HStack(spacing: 12) {
                    ForEach(0..<onboardingPages.count, id: \.self) { i in
                        Circle()
                            .fill(i == currentPage ? Color(hex: "#A18CD1") : Color.white.opacity(0.5))
                            .frame(width: 12, height: 12)
                    }
                }
                .padding(.bottom, 8)

                // Navigation buttons
                HStack(spacing: 16) {
                    if currentPage > 0 {
                        Button(action: { withAnimation { currentPage -= 1 } }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(Color(hex: "#A18CD1"))
                                .frame(width: 44, height: 44)
                                .background(Color.white.opacity(0.18))
                                .clipShape(Circle())
                        }
                    }
                    Spacer()
                    if currentPage < onboardingPages.count - 1 {
                        Button(action: { withAnimation { currentPage += 1 } }) {
                            Image(systemName: "chevron.right")
                                .font(.title2)
                                .foregroundColor(Color(hex: "#A18CD1"))
                                .frame(width: 44, height: 44)
                                .background(Color.white.opacity(0.18))
                                .clipShape(Circle())
                        }
                    } else {
                        Button(action: { onFinish?() }) {
                            Text("Get Started")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: 180)
                                .padding()
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(hex: "#A18CD1"), Color(hex: "#FBC2EB")]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                                .shadow(color: Color(hex: "#B39DDB").opacity(0.18), radius: 8, x: 0, y: 4)
                        }
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
        }
    }
}

// ... Color hex extension ...
