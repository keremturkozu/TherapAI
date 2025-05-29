// SessionCompletedView.swift
// Shown after the last question. Congratulates the user and transitions to results with a loading animation.
// Modern, soft, and motivating design for therapy app.

import SwiftUI

struct SessionCompletedView: View {
    @State private var isLoading: Bool = false
    @State private var showResults: Bool = false
    var onSeeResults: (() -> Void)? = nil
    
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
                // Başarı ikonu
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .foregroundColor(Color(hex: "#A18CD1"))
                    .shadow(radius: 10)

                Text("Congratulations, session completed!")
                    .font(.title2.bold())
                    .foregroundColor(Color(hex: "#4A148C"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                Text("Your answers will be analyzed by AI.")
                    .font(.body)
                    .foregroundColor(Color(hex: "#4A148C").opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer()

                if isLoading {
                    VStack(spacing: 16) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color(hex: "#A18CD1")))
                            .scaleEffect(1.5)
                        Text("Preparing your results...")
                            .font(.body)
                            .foregroundColor(Color(hex: "#4A148C"))
                    }
                    .transition(.opacity)
                } else {
                    Button(action: {
                        withAnimation { isLoading = true }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            showResults = true
                            onSeeResults?()
                        }
                    }) {
                        Text("See Results")
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
                }
                Spacer(minLength: 40)
            }
        }
    }
}
// ... Color hex extension ...
