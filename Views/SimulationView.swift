//
//  SimulationView.swift
//
//  Created by Kaylie Sampson on 10/1/20.
//
/*
import SwiftUI
import ComposableArchitecture
import Simulation
import Grid

public struct SimulationView: View {
    let store: Store<SimulationState, SimulationState.Action>

    public init(store: Store<SimulationState, SimulationState.Action>) {
        self.store = store
    }

    public var body: some View {
        
        NavigationView {
            VStack{
                Spacer()
            }
            }
            /*
            WithViewStore(store) { viewStore in
                VStack {
                    GeometryReader { g in
                        if g.size.width < g.size.height {
                            self.verticalContent(for: viewStore, geometry: g)
                        } else {
                            self.horizontalContent(for: viewStore, geometry: g)
                        }
                    }
                }
            .background(Color("simBackground"))
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle("Simulation")
                .navigationBarHidden(false)
                // Problem 6 - your answer goes here.
                self.onAppear{
                    //viewStore.isRunningTimer = false
                }
                self.onDisappear{
                    //viewStore.shouldRestartTimer = true
                }
            }
 */
    }
}
/*
    func verticalContent(
        for viewStore: ViewStore<SimulationState, SimulationState.Action>,
        geometry g: GeometryProxy
    ) -> some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            InstrumentationView(
                store: self.store,
                width: g.size.width * 0.82
            )
            .frame(height: g.size.height * 0.35)
            .padding(.bottom, 16.0)

            Divider()
            
            EmptyView()
                .modifier(
                    GridAnimationModifier(
                        store: self.store.scope(
                            state: \.gridState,
                            action: SimulationState.Action.grid(action:)
                        ),
                        configuration: GridView.Configuration(),
                        fractionComplete: viewStore.state.isAtStartOfAnimation ? 0.0 : 1.0
                    )
            )
        }
    }

    func horizontalContent(
        for viewStore: ViewStore<SimulationState, SimulationState.Action>,
        geometry g: GeometryProxy
    ) -> some View {
        HStack {
            Spacer()
            InstrumentationView(store: self.store)
            Spacer()
            Divider()
            GridView(
                store: self.store.scope(
                    state: \.gridState,
                    action: SimulationState.Action.grid(action:)
                ), fractionComplete: 1.0
            )
            .frame(width: g.size.height)
            Spacer()
        }
    }
}
*/
public struct SimulationView_Previews: PreviewProvider {
    static let previewState = SimulationState()
    public static var previews: some View {
        SimulationView(
            store: Store(
                initialState: previewState,
                reducer: simulationReducer,
                environment: SimulationEnvironment()
            )
        )
    }
 }
*/
