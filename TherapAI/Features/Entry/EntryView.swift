// EntryView.swift
// Motivating, hope-giving entry screen for TherapAI after onboarding.
// Highlights the benefits of regular therapy and encourages the user before starting a session.
// Includes a responsible AI disclaimer. All cards are now perfectly aligned and responsive.

import SwiftUI

struct EntryView: View {
    var onStart: (() -> Void)? = nil
    @State private var showDisclaimer = false
    @State private var isPreparing = false
    var body: some View {
        ZStack {
            if isPreparing {
                PreparationView(onComplete: {
                    isPreparing = false
                    onStart?()
                })
            } else {
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "#EDE7F6"), Color(hex: "#B3C6E6")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 32) {
                    Spacer().frame(height: 40)
                    // Responsive başlık
                    Text("TherapAI is here to help you grow, heal, and thrive.")
                        .font(.title3.bold())
                        .foregroundColor(Color(hex: "#4A148C"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .lineLimit(nil)
                        .minimumScaleFactor(0.5)
                        .fixedSize(horizontal: false, vertical: true)

                    // Kartlar parent'ı
                    VStack(spacing: 22) {
                        EntryBenefitCard(emoji: "🌱", text: "Regular sessions help you gain clarity and peace of mind.")
                        EntryBenefitCard(emoji: "💡", text: "Reflect on your feelings and discover new perspectives.")
                        EntryBenefitCard(emoji: "🛡️", text: "Overcome stress and anxiety with guided support.")
                        EntryBenefitCard(emoji: "✨", text: "Feel lighter, more balanced, and in control.")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 24)

                    Spacer()

                    VStack(spacing: 12) {
                        Button(action: {
                            isPreparing = true
                        }) {
                            Text("Start My Therapy Session")
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
                        .padding(.bottom, 0)

                        // Info/uyarı kutusu
                        Button(action: { showDisclaimer = true }) {
                            HStack(spacing: 8) {
                                Image(systemName: "info.circle")
                                    .foregroundColor(Color(hex: "#A18CD1"))
                                Text("Important AI Disclaimer")
                                    .font(.footnote)
                                    .foregroundColor(Color(hex: "#4A148C"))
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.7))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        .padding(.horizontal, 48)
                        .sheet(isPresented: $showDisclaimer) {
                            DisclaimerSheet()
                        }
                    }
                    .padding(.bottom, 32)

                    Text("Your journey to well-being starts here.")
                        .font(.footnote)
                        .foregroundColor(Color(hex: "#4A148C").opacity(0.7))
                        .padding(.bottom, 8)
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
}

struct EntryBenefitCard: View {
    let emoji: String
    let text: String
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text(emoji)
                .font(.system(size: 28))
                .frame(width: 36, height: 36)
                .background(Color.white.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            Text(text)
                .font(.body)
                .foregroundColor(Color(hex: "#4A148C"))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(Color.white.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color(hex: "#B39DDB").opacity(0.08), radius: 4, x: 0, y: 2)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct DisclaimerSheet: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#F3EAFD"), Color(hex: "#EDE7F6")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack(spacing: 28) {
                Spacer().frame(height: 24)
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.yellow)
                    .padding(.top, 8)
                Text("Important Disclaimer")
                    .font(.title2.bold())
                    .foregroundColor(Color(hex: "#4A148C"))
                    .multilineTextAlignment(.center)
                VStack(alignment: .leading, spacing: 18) {
                    Text("The suggestions and results in this app are generated by AI and are for informational purposes only. If you are experiencing serious mental health issues, please consult a licensed professional. Do not rely on this app for medical advice or medication.")
                        .font(.body)
                        .foregroundColor(Color(hex: "#4A148C").opacity(0.9))
                        .multilineTextAlignment(.leading)
                    Text("TherapAI does not provide crisis support. If you are in crisis or need immediate help, contact emergency services or a mental health professional.")
                        .font(.body)
                        .foregroundColor(Color(hex: "#4A148C").opacity(0.9))
                        .multilineTextAlignment(.leading)
                    Text("No content in this app should be considered a substitute for professional medical advice, diagnosis, or treatment.")
                        .font(.body)
                        .foregroundColor(Color(hex: "#4A148C").opacity(0.9))
                        .multilineTextAlignment(.leading)
                    Text("Never disregard professional medical advice or delay seeking it because of something you have read in this app.")
                        .font(.body)
                        .foregroundColor(Color(hex: "#4A148C").opacity(0.9))
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, 24)
                Spacer()
                Button(action: { dismiss() }) {
                    Text("Close")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#A18CD1"))
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .shadow(color: Color(hex: "#B39DDB").opacity(0.15), radius: 6, x: 0, y: 2)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
            }
        }
    }
}

enum Mood: String, CaseIterable {
    case happy, neutral, sad, loved, stressed
    var emoji: String {
        switch self {
        case .happy: return "🙂"
        case .neutral: return "😐"
        case .sad: return "😔"
        case .loved: return "😍"
        case .stressed: return "😵‍💫"
        }
    }
}

struct PreparationView: View {
    var onComplete: (() -> Void)?
    @State private var isAnimating = false
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
                Image(systemName: "sparkles")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color(hex: "#A18CD1"))
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false), value: isAnimating)
                Text("Preparing your personal session...")
                    .font(.title3.bold())
                    .foregroundColor(Color(hex: "#4A148C"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                Text("Take a deep breath and get ready. This is your time.")
                    .font(.body)
                    .foregroundColor(Color(hex: "#4A148C").opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                Spacer()
            }
            .onAppear {
                isAnimating = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    onComplete?()
                }
            }
        }
    }
}

#Preview {
    EntryView()
}
