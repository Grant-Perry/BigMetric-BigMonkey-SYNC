//
//  BigMetricApp.swift
//  BigMetric Watch App
//
//  Created by: Grant Perry on 5/25/23.

//			Trust ONLY this project Modified: Tuesday January 9, 2024 at 8:28:11 PM

//			DEVELOP MODE branch

import SwiftUI

let APP_NAME 		= "BigMetric"
let APP_VERSION 	= "d2.9 RhiNO-M0nkEY"
let MOD_DATE 		= "Mod: 1/9/24 - 8:28 PM"

@main
struct BigMetric_Watch_AppApp: App {
   @Environment(\.scenePhase) var scenePhase
	@State var distanceTracker: DistanceTracker = DistanceTracker()
	@State var workoutManager: WorkoutManager = WorkoutManager(distanceTracker: DistanceTracker())
	@State var weatherKitManager: WeatherKitManager = WeatherKitManager(distanceTracker: DistanceTracker())
	@State var geoCodeHelper: GeoCodeHelper = GeoCodeHelper(distanceTracker: DistanceTracker())
   @State private var distanceTrackerInitialized = false
   @State private var selectedTab = 2
	

   var body: some Scene {
      WindowGroup {
         TabView(selection: $selectedTab) {

				endWorkout(distanceTracker: distanceTracker,
							  workoutManager: workoutManager,
							  selectedTab: $selectedTab) // when end workout is finished
               .tabItem { Image(systemName: "circle.fill") }
               .tag(0)

				howFarGPS(distanceTracker: distanceTracker,
							 workoutManager: workoutManager)
               .tabItem { Image(systemName: "circle.fill") }
               .tag(2)

				debugScreen(distanceTracker: distanceTracker,
								workoutManager: workoutManager,
								weatherKitManager: weatherKitManager,
								geoCodeHelper: geoCodeHelper)
               .tabItem { Image(systemName: "circle.fill") }
               .tag(3)

				summary(distanceTracker: distanceTracker,
						  workoutManager: workoutManager,
						  selectedTab: $selectedTab)
					.tag(4)

				AltitudeView(distanceTracker: distanceTracker)
					.tabItem { Image(systemName: "circle.fill") }
					.tag(5)

				CompassView(workoutManager: workoutManager,
								heading: 0.0, routeHeading: 0.0)
               .tabItem { Image(systemName: "circle.fill") }
               .tag(6)

				showHeartBeat(distanceTracker: distanceTracker)
					.tabItem { Image(systemName: "circle.fill") }
					.tag(7)

//				varView()
//					.tabItem { Image(systemName: "circle.fill") }
//					.tag(7)

         }
         .onAppear {
            self.selectedTab = 2
            workoutManager.requestHKAuth()
         }
         .tabViewStyle(PageTabViewStyle())
      }
   }
}


