// QuestionsView.swift
// Therapy app question screen with soft, inviting, pastel colors and modern Apple Design.
// Soft lavender/blue background, white-mauve cards, pastel button, and improved layout.
// Handles question navigation, answer saving, and safe area top bar.
// All UI is in English. Apple Design Tips are followed.

import SwiftUI

struct QuestionsView: View {
    var onBack: (() -> Void)? = nil
    var onFinish: (() -> Void)? = nil
    @State private var currentQuestionIndex: Int = 0
    let questions = [
        "How are you feeling today?",
        "What is something that made you smile recently?",
        "Is there anything on your mind you'd like to talk about?",
        "What is one thing you are grateful for?"
    ]
    @State private var answers: [String] = Array(repeating: "", count: 4)
    @FocusState private var isAnswerFocused: Bool
    
    var body: some View {
        ZStack {
            // Soft, inviting gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#EDE7F6"), Color(hex: "#B3C6E6")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer().frame(height: 100)
                // Soru Kartı
                ZStack {
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .fill(Color.white.opacity(0.85))
                        .background(
                            BlurView(style: .systemMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                        )
                        .shadow(color: Color(hex: "#B39DDB").opacity(0.10), radius: 12, x: 0, y: 6)
                    Text(questions[currentQuestionIndex])
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(hex: "#4A148C"))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 32)
                        .padding(.horizontal, 20)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(minHeight: 80, maxHeight: 200, alignment: .center)
                        .transition(.opacity)
                        .id(currentQuestionIndex)
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 28)
                .animation(.easeInOut, value: currentQuestionIndex)

                // Cevap Kartı (sadece bu alan scrollable)
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.white.opacity(0.75))
                            .background(
                                BlurView(style: .systemMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            )
                            .shadow(color: Color(hex: "#B39DDB").opacity(0.08), radius: 8, x: 0, y: 3)
                        if answers[currentQuestionIndex].isEmpty {
                            Text("Type your answer...")
                                .foregroundColor(Color.gray.opacity(0.7))
                                .font(.body)
                                .frame(maxWidth: .infinity, minHeight: 80, alignment: .center)
                        }
                        TextEditor(text: Binding(
                            get: { answers[currentQuestionIndex] },
                            set: { answers[currentQuestionIndex] = $0 }
                        ))
                        .focused($isAnswerFocused)
                        .id(currentQuestionIndex)
                        .frame(minHeight: 80, maxHeight: 120)
                        .padding(10)
                        .background(Color.clear)
                        .scrollContentBackground(.hidden)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(isAnswerFocused ? Color(hex: "#9575CD") : Color(hex: "#B39DDB").opacity(0.18), lineWidth: 2)
                        )
                        .font(.body)
                        .foregroundColor(Color(hex: "#4A148C"))
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 32)
                    .animation(.easeInOut, value: isAnswerFocused)
                }
                .frame(height: 120)

                Spacer(minLength: 0)

                // Next button
                Button(action: {
                    if currentQuestionIndex < questions.count - 1 {
                        currentQuestionIndex += 1
                        isAnswerFocused = false
                    } else {
                        onFinish?()
                    }
                }) {
                    Text(currentQuestionIndex == questions.count - 1 ? "Finish" : "Next")
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
                .padding(.bottom, 40)
            }
        }
        .safeAreaInset(edge: .top) {
            // Modern üst bar
            HStack(spacing: 0) {
                Button(action: {
                    if currentQuestionIndex > 0 {
                        currentQuestionIndex -= 1
                        isAnswerFocused = false
                    } else {
                        onBack?()
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(hex: "#4A148C"))
                        .frame(width: 44, height: 44)
                        .background(Color.white.opacity(0.18))
                        .clipShape(Circle())
                        .shadow(color: Color(hex: "#B39DDB").opacity(0.10), radius: 4, x: 0, y: 2)
                }
                .padding(.leading, 12)
                Spacer()
                ProgressDots(current: currentQuestionIndex, total: questions.count)
                    .frame(height: 24)
                    .padding(.trailing, 24) // Dotları sağa yaklaştır
            }
            .padding(.top, 8)
            .padding(.bottom, 8)
            .padding(.horizontal, 16)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "#EDE7F6"), Color(hex: "#B3C6E6")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

// ProgressDots: Shows progress as filled and empty circles
struct ProgressDots: View {
    let current: Int
    let total: Int
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \ .self) { i in
                Circle()
                    .fill(i == current ? Color.purple : Color.white.opacity(0.5))
                    .frame(width: 12, height: 12)
            }
        }
    }
}

// UIKit BlurView for glassmorphism effect
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

// HEX renk desteği
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    QuestionsView()
}
