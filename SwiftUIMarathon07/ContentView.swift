//
//  ContentView.swift
//  SwiftUIMarathon07
//
//  Created by Mike Rudoy on 16/05/2024.
//

import SwiftUI

struct ContentView: View {
    private let padding: CGFloat = 20.0
    
    @Namespace private var animation
    @State var isExpanded: Bool = false
    @State var backgroundViewShouldBeClear = true
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: isExpanded ? .leading : .bottomTrailing) {
                Rectangle()
                    .fill(Color.clear)
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(backgroundViewShouldBeClear ? Color.clear : Color.blue)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    button
                }
                .cornerRadius(10)
                .fixedSize(horizontal: !isExpanded, vertical: !isExpanded)
                .frame(
                    maxWidth: isExpanded ? (geometry.size.width - padding * 2) : .infinity,
                    maxHeight: isExpanded ? geometry.size.height /  2.0  : .infinity,
                    alignment: .bottomTrailing
                )
            }.padding(padding)
        }
    }
    
    var button: some View {
        Button(action: {
            backgroundViewShouldBeClear = false
            withAnimation {
                isExpanded.toggle()
            } completion: {
                if isExpanded {
                    backgroundViewShouldBeClear = false
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        if !isExpanded {
                            backgroundViewShouldBeClear = true
                        }
                    }
                }
            }

        }, label: {
            if isExpanded {
                HStack {
                    Image(systemName: "arrowshape.backward.fill")
                    Text("Close")
                }
                .fixedSize(horizontal: true, vertical: false)
                .matchedGeometryEffect(id: "caption", in: animation)
            } else {
                Text("Open")
                    .matchedGeometryEffect(id: "caption", in: animation)
            }
        })
        .buttonStyle(CustomButtonStyle(normalColor: .white))
        .foregroundColor(Color.white)
        .bold()
        .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}

struct CustomButtonStyle: ButtonStyle {
    var normalColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(normalColor)
            .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
            .background(configuration.isPressed ? .blue.opacity(0.5) : .blue)
            .bold()
    }
}
