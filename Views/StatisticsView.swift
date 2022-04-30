//
//  StatisticsView.swift
//
//  Created by Kaylie Sampson 10/5/20
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Statistics

public struct StatisticsView: View {
    let store: Store<StatisticsState, StatisticsState.Action>
    let viewStore: ViewStore<StatisticsState, StatisticsState.Action>

    public init(store: Store<StatisticsState, StatisticsState.Action>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    @State var controller = ViewController()
    public var body: some View {
        NavigationView {
            GeometryReader { g in
                VStack {
                    Spacer()
                    Button(action: {
                        controller.linkCDC()
                    }) {
                        Text("Centers for Disease Control and Prevention (CDC)").font(.system(size: 24.0))
                    }
                    .background(Color(.white))
                    .frame(width: 350.0, height: 100.0, alignment: .center)
                    .background(Color(.white))
                    .overlay(Rectangle().stroke(Color("accent"), lineWidth: 10.0))
                    Spacer()
                    Button(action: {
                        controller.linkWHO()
                    }) {
                        Text("World Health Organization").font(.system(size: 24.0))
                    }
                    .background(Color(.white))
                    .frame(width: 350.0, height: 100.0, alignment: .center)
                    .background(Color(.white))
                    .overlay(Rectangle().stroke(Color("accent"), lineWidth: 10.0))
                    Spacer()
                    Button(action: {
                        controller.linkWMD()
                    }) {
                        Text("WebMD Coronavirus Overview").font(.system(size: 24.0))
                    }
                    .background(Color(.white))
                    .frame(width: 350.0, height: 100.0, alignment: .center)
                    .background(Color(.white))
                    .overlay(Rectangle().stroke(Color("accent"), lineWidth: 10.0))
                    Spacer()
                    Button(action: {
                        controller.linkJHMap()
                    }) {
                        Text("John's Hopkins Covid-19 Map").font(.system(size: 24.0))
                    }
                    .background(Color(.white))
                    .frame(width: 350.0, height: 100.0, alignment: .center)
                    .background(Color(.white))
                    .overlay(Rectangle().stroke(Color("accent"), lineWidth: 10.0))
                    Spacer()
                }
                .frame(width: g.size.width * 1, alignment: .center)
            }
            .navigationBarTitle(Text("Covid-19 Resources"))
            .background(Color("gridBackground"))
        }
    }

    var title: some View {
        HStack {
            Text("Statistics")
                .font(.system(size: 48))
                .bold()
                .foregroundColor(Color("accent"))
        }
    }
}

public struct StatisticsView_Previews: PreviewProvider {
    static let previewState = StatisticsState()
    public static var previews: some View {
        StatisticsView(
            store: Store(
                initialState: previewState,
                reducer: statisticsReducer,
                environment: StatisticsEnvironment()
            )
        )
    }
}

