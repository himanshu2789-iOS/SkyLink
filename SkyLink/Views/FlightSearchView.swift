//
//  FlightSearchView.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct FlightSearchView: View {
    @State private var viewModel = FlightSearchViewModel()
    @State private var navigateToResults = false
    @State private var rotateSwap = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.18),
                        Color.white,
                        Color.white
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 28) {
                        heroSection
                        SearchCard(
                            departure: $viewModel.departureCity,
                            arrival: $viewModel.arrivalCity,
                            departureDate: $viewModel.departureDate,
                            passengerCount: $viewModel.passengerCount,
                            rotateSwap: $rotateSwap,
                            onSwap: swapCities,
                            onSearch: searchFlights
                        )
                        
                        DestinationSection()
                        
                    }
                    .padding(.horizontal,20)
                    .padding(.bottom,40)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToResults) {
                FlightResultsView(viewModel: viewModel)
            }
        }
    }
    
    var heroSection: some View {
        
        VStack(alignment: .leading, spacing: 22) {
            
            // MARK: Brand Header
            HStack(spacing: 16) {
                Image("plane")       // <-- Your image name in Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("SkyLink")
                        .font(.system(size: 32,
                                      weight: .black,
                                      design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .cyan],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    Text("Fly Beyond Expectations")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                }
                Spacer()
                HStack(spacing: 6) {
                    Circle()
                        .fill(.green)
                        .frame(width: 8, height: 8)
                    Text("Live")
                        .font(.caption.bold())
                    
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
            }
            // MARK: Hero Text
            VStack(alignment: .leading, spacing: 10) {
                Text("Explore the World")
                    .font(.system(size: 42,
                                  weight: .black,
                                  design: .rounded))
                Text("Find premium flights to over 120 destinations worldwide.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .lineSpacing(4)
                
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
    }
    
    func swapCities(){
        withAnimation(.spring(response:0.45,
                              dampingFraction:0.75)){
            rotateSwap.toggle()
            let from = viewModel.departureCity
            viewModel.departureCity = viewModel.arrivalCity
            viewModel.arrivalCity = from
        }
    }
    
    func searchFlights(){
        Task{
            await viewModel.performSearch()
            navigateToResults = true
            
        }
        
    }
}
