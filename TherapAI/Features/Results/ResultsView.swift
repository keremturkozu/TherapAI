// ResultsView.swift
// Creative, modern, and motivating results screen for therapy app.
// Shows emotional state, awareness notes, and actionable suggestions in soft cards.

import SwiftUI

struct ResultsView: View {
    var onStartNew: (() -> Void)? = nil
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#EDE7F6"), Color(hex: "#B3C6E6")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    Spacer().frame(height: 32)
                    // Üstte ikon/animasyon
                    Image(systemName: "sparkles")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color(hex: "#A18CD1"))
                        .shadow(radius: 8)
                        .padding(.bottom, 8)

                    Text("Your Session Insights")
                        .font(.title2.bold())
                        .foregroundColor(Color(hex: "#4A148C"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8)

                    // Kartlar
                    VStack(spacing: 20) {
                        ResultCardView(
                            title: "Emotional State",
                            icon: "face.smiling",
                            content: "Calm & Thoughtful",
                            description: "You seem to be feeling calm and open to reflection today."
                        )
                        ResultCardView(
                            title: "Awareness Notes",
                            icon: "lightbulb",
                            content: "Grateful for small moments",
                            description: "You're noticing the little things and practicing gratitude."
                        )
                        ResultCardView(
                            title: "Actions & Suggestions",
                            icon: "sparkle.magnifyingglass",
                            content: "🌱 Take a mindful walk\n✍️ Write down one thing you're grateful for\n☕️ Treat yourself to a relaxing break",
                            description: nil
                        )
                    }
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)

                    Button(action: {
                        onStartNew?()
                    }) {
                        Text("Start New Session")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
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
                    .padding(.horizontal, 32)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct ResultCardView: View {
    let title: String
    let icon: String
    let content: String
    let description: String?
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(Color(hex: "#A18CD1"))
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(hex: "#4A148C"))
            }
            Text(content)
                .font(.body.weight(.medium))
                .foregroundColor(Color(hex: "#4A148C"))
                .fixedSize(horizontal: false, vertical: true)
            if let desc = description {
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#4A148C").opacity(0.7))
            }
        }
        .padding(18)
        .background(Color.white.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color(hex: "#B39DDB").opacity(0.10), radius: 8, x: 0, y: 4)
        .frame(maxWidth: .infinity)
    }
}

// ... Color hex extension ...
