//
//  BookingSummaryView.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct BookingSummaryView: View {
    @Bindable var viewModel: FlightSearchViewModel
    @State private var isPaying = false
    @State private var bookingConfirmed = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Confirm Card
                VStack(spacing: 16) {
                    Image(systemName: "creditcard.circle.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.blue)
                    
                    Text("Payment Summary")
                        .font(.headline)
                }
                .padding(.top)
                
                // Flight Card Overview
                if let flight = viewModel.selectedFlight {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Selected Route")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Text(flight.departureCity)
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Spacer()
                            Image(systemName: "arrow.right")
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(flight.arrivalCity)
                                .font(.subheadline)
                                .fontWeight(.bold)
                        }
                        
                        Divider()
                        
                        HStack {
                            Label(flight.airline, systemImage: "airplane")
                                .font(.caption)
                            Spacer()
                            Text(flight.duration)
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                
                // Fare Details
                VStack(alignment: .leading, spacing: 12) {
                    Text("Fare Details")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    VStack(spacing: 10) {
                        HStack {
                            Text("Base Fare (\(viewModel.passengerCount)x)")
                            Spacer()
                            Text("$\(Int(viewModel.baseFareTotal))")
                        }
                        
                        if viewModel.seatMarkupTotal > 0 {
                            HStack {
                                Text("Premium Seat Markup")
                                Spacer()
                                Text("$\(Int(viewModel.seatMarkupTotal))")
                            }
                        }
                        
                        HStack {
                            Text("Taxes and Fees")
                            Spacer()
                            Text("$\(Int(viewModel.taxesAndFees))")
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Total Amount Due")
                                .fontWeight(.bold)
                            Spacer()
                            Text("$\(Int(viewModel.grandTotal))")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
                    .padding(.horizontal)
                }
                
                // Pay Button
                if !bookingConfirmed {
                    Button(action: {
                        isPaying = true
                        Task {
                            try? await Task.sleep(nanoseconds: 1_200_000_000) // 1.2s
                            isPaying = false
                            bookingConfirmed = true
                        }
                    }) {
                        HStack {
                            if isPaying {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text("Pay $\(Int(viewModel.grandTotal)) with Apple Pay")
                                    .fontWeight(.bold)
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                    .disabled(isPaying)
                    .padding(.horizontal)
                } else {
                    // Confirmed Success
                    VStack(spacing: 16) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.green)
                        
                        Text("Booking Confirmed!")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Your ticket was successfully processed. A receipt and digital pass have been dispatched to your email address.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Button(action: {
                            viewModel.resetBookingState()
                            // Navigate all the way back to root
                        }) {
                            Text("Done & Search New Flights")
                                .fontWeight(.semibold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                        }
                        .padding(.top, 12)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(18)
                    .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Booking Summary")
        .navigationBarTitleDisplayMode(.inline)
    }
}
