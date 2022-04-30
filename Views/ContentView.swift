//
//  ContentView.swift
//
//  Created by Kaylie Sampson 10/5/20
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Configurations
import Statistics
import MessageUI

struct ContentView: View {
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    var store: Store<AppState, AppState.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            TabView(selection: viewStore.binding(
                get: \.selectedTab,
                send: AppState.Action.setSelectedTab(tab:)
            )) {
                self.configurationsView()
                    .tag(AppState.Tab.configuration)
                self.statisticsView()
                    .tag(AppState.Tab.statistics)
            }
            .accentColor(Color("accent"))
        }
    }
    private func statisticsView() -> some View {
        StatisticsView(
            store: store.scope(
                state: \.statisticsState,
                action: AppState.Action.statisticsAction(action:)
            )
        )
        .tabItem {
            Image(systemName: "paperclip.circle")
            Text("Resources")
        }
    }
    private func configurationsView() -> some View {
        ConfigurationsView(
            store: self.store.scope(
                state: \.configurationState,
                action: AppState.Action.configurationsAction(action:)
            )
        )
        .tabItem {
            Image(systemName: "staroflife.fill")
            Text("Testing")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static let previewState = AppState()
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: previewState,
                reducer: appReducer,
                environment: AppEnvironment()
            )
        )
    }
}
