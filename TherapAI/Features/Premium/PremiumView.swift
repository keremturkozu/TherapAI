// PremiumView.swift
// Modern, user-friendly, single-page premium screen for TherapAI.
// Shows benefits, 3 subscription options, and a big upgrade button.
// Each label is surrounded by its own laurel, Lifetime subtitle is multiline, and description fits.

import SwiftUI

struct PremiumView: View {
    @State private var selected: PremiumOption = .yearly
    var onUpgrade: (() -> Void)? = nil
    var onRestore: (() -> Void)? = nil
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#EDE7F6"), Color(hex: "#B3C6E6")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {
                Spacer().frame(height: 32)
                // Her yazı için kendi laurel'ı
                HStack(spacing: 32) {
                    FlamaBadge(text: "10K+ Users")
                    FlamaBadge(text: "Best Therapy App")
                }
                .frame(maxWidth: .infinity)

                // Başlık ve açıklama
                Text("Upgrade to TherapAI Premium")
                    .font(.title2.bold())
                    .foregroundColor(Color(hex: "#4A148C"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                Text("Unlock unlimited sessions, advanced AI insights, and more.")
                    .font(.body)
                    .foregroundColor(Color(hex: "#4A148C").opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .lineLimit(nil)
                    .minimumScaleFactor(0.7)
                    .fixedSize(horizontal: false, vertical: true)

                // Avantajlar
                VStack(spacing: 12) {
                    PremiumBenefitRow(icon: "infinity", text: "Unlimited therapy sessions")
                    PremiumBenefitRow(icon: "brain.head.profile", text: "Advanced AI-powered insights")
                    PremiumBenefitRow(icon: "star.fill", text: "Priority support")
                    PremiumBenefitRow(icon: "sparkles", text: "Early access to new features")
                }
                .padding(.horizontal, 16)

                // Abonelik seçenekleri
                HStack(spacing: 16) {
                    ForEach(PremiumOption.allCases, id: \.self) { option in
                        PremiumOptionCard(option: option, isSelected: selected == option)
                            .onTapGesture { selected = option }
                    }
                }
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity)

                // Satın al butonu
                Button(action: { onUpgrade?() }) {
                    Text(selected.buttonTitle)
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
                .padding(.top, 8)

                // Restore ve terms
                VStack(spacing: 8) {
                    Button(action: { onRestore?() }) {
                        Text("Already purchased? Restore")
                            .font(.footnote)
                            .foregroundColor(Color(hex: "#4A148C"))
                            .underline()
                    }
                    HStack(spacing: 12) {
                        Button(action: { /* open terms */ }) {
                            Text("Terms of Use")
                                .font(.footnote)
                                .foregroundColor(Color(hex: "#4A148C").opacity(0.7))
                        }
                        Circle().frame(width: 4, height: 4).foregroundColor(Color(hex: "#4A148C").opacity(0.3))
                        Button(action: { /* open privacy */ }) {
                            Text("Privacy Policy")
                                .font(.footnote)
                                .foregroundColor(Color(hex: "#4A148C").opacity(0.7))
                        }
                    }
                }
                .padding(.top, 4)
                Spacer()
            }
        }
    }
}

struct FlamaBadge: View {
    let text: String
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Image(systemName: "laurel.leading")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(hex: "#A18CD1"), Color(hex: "#9575CD")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                Spacer(minLength: 0)
                Image(systemName: "laurel.trailing")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(hex: "#A18CD1"), Color(hex: "#9575CD")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            .frame(width: 120, height: 60)
            Text(text)
                .font(.headline.bold())
                .foregroundColor(Color(hex: "#4A148C"))
                .shadow(color: .white.opacity(0.5), radius: 2, x: 0, y: 1)
        }
        .frame(width: 120, height: 60)
    }
}

enum PremiumOption: CaseIterable {
    case yearly, monthly, lifetime
    var title: String {
        switch self {
        case .yearly: return "Yearly"
        case .monthly: return "Monthly"
        case .lifetime: return "Lifetime"
        }
    }
    var price: String {
        switch self {
        case .yearly: return "$49.99"
        case .monthly: return "$7.99"
        case .lifetime: return "$99.99"
        }
    }
    var subtitle: String? {
        switch self {
        case .yearly: return "Best Value"
        case .monthly: return nil
        case .lifetime: return "One-time purchase"
        }
    }
    var buttonTitle: String {
        switch self {
        case .yearly: return "Continue with Yearly ($49.99)"
        case .monthly: return "Continue with Monthly ($7.99)"
        case .lifetime: return "Continue with Lifetime ($99.99)"
        }
    }
}

struct PremiumOptionCard: View {
    let option: PremiumOption
    let isSelected: Bool
    var body: some View {
        VStack(spacing: 6) {
            Text(option.title)
                .font(.headline)
                .foregroundColor(isSelected ? Color(hex: "#4A148C") : Color(hex: "#4A148C").opacity(0.7))
            Text(option.price)
                .font(.title3.bold())
                .foregroundColor(isSelected ? Color(hex: "#A18CD1") : Color(hex: "#4A148C").opacity(0.7))
            if let subtitle = option.subtitle {
                if option == .lifetime {
                    VStack(spacing: 0) {
                        Text("One-time")
                            .font(.caption2.bold())
                            .minimumScaleFactor(0.7)
                            .lineLimit(1)
                            .foregroundColor(.white)
                        Text("purchase")
                            .font(.caption2.bold())
                            .minimumScaleFactor(0.7)
                            .lineLimit(1)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 4)
                    .padding(.vertical, 1)
                    .background(Color(hex: "#A18CD1"))
                    .clipShape(Capsule())
                } else {
                    Text(subtitle)
                        .font(.caption2.bold())
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 1)
                        .background(Color(hex: "#A18CD1"))
                        .clipShape(Capsule())
                }
            }
        }
        .padding(16)
        .frame(width: 110, height: 110)
        .background(isSelected ? Color.white : Color.white.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: isSelected ? Color(hex: "#A18CD1").opacity(0.18) : Color.clear, radius: 8, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(isSelected ? Color(hex: "#A18CD1") : Color.clear, lineWidth: 2)
        )
    }
}

struct PremiumBenefitRow: View {
    let icon: String
    let text: String
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(Color(hex: "#A18CD1"))
                .frame(width: 28, height: 28)
            Text(text)
                .font(.body)
                .foregroundColor(Color(hex: "#4A148C"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
// ... Color hex extension ...
