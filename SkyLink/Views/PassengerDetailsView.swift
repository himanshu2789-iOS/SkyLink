//
//  PassengerDetailsView.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct PassengerDetailsView: View {
    @Bindable var viewModel: FlightSearchViewModel
    @State private var navigateToSummary = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Passenger Information")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                ForEach(0..<viewModel.passengerCount, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("Passenger #\(index + 1)")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                            if index < viewModel.selectedSeats.count {
                                Text("Seat \(viewModel.selectedSeats[index].id)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.12))
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.bottom, 4)
                        
                        // Name Field
                        VStack(alignment: .leading, spacing: 6) {
                            Text("FULL NAME")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            
                            TextField("As shown in passport", text: $viewModel.passengers[index].name)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        
                        // Email Field
                        VStack(alignment: .leading, spacing: 6) {
                            Text("EMAIL ADDRESS")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            
                            TextField("name@domain.com", text: $viewModel.passengers[index].email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        
                        // Passport Number
                        VStack(alignment: .leading, spacing: 6) {
                            Text("PASSPORT NUMBER")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            
                            TextField("E.g., N12345678", text: $viewModel.passengers[index].passportNumber)
                                .autocapitalization(.allCharacters)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
                    .padding(.horizontal)
                }
                
                Button(action: { navigateToSummary = true }) {
                    Text("Proceed to Billing")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(allFieldsFilled ? Color.blue : Color.gray)
                        .cornerRadius(12)
                }
                .disabled(!allFieldsFilled)
                .padding()
            }
        }
        .navigationTitle("Passenger Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $navigateToSummary) {
            BookingSummaryView(viewModel: viewModel)
        }
    }
    
    private var allFieldsFilled: Bool {
        return viewModel.passengers.allSatisfy { passenger in
            !passenger.name.isEmpty && !passenger.email.isEmpty && !passenger.passportNumber.isEmpty
        }
    }
}
