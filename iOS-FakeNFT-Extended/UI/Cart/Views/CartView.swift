//
//  CartView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Svetlana on 2026/7/29.
//
import SwiftUI

struct CartView: View {
    
    @State private var viewModel: CartViewModel
    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.items.isEmpty {
                emptyStateView
            } else {
                list
                bottomBar
            }
        }
        .alert(Constants.failed, isPresented: $viewModel.showErrorAlert) {
            Button(Constants.cancel, role: .cancel) { }
            Button(Constants.errorRepeat) {
                Task {
                    await viewModel.loadItems()
                }
            }
        }
        .background(Color(.whitePrimary))
        .task {
            await viewModel.loadItems()
        }
    }
    
    // MARK: List
    private var list: some View {
        ScrollView {
            filterButton
            VStack(spacing: 20) {
                ForEach(viewModel.items) { item in
                    CartCell(item: item) {
                        viewModel.removeItem(item)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Header
    private var filterButton: some View {
        HStack {
            Spacer()
            Image(.filterButton)
                .frame(width: 42, height: 42)
        }
        .padding(.horizontal, 9)
        .padding(.bottom, 20)
    }
    
    // MARK: Bottom bar
    private var bottomBar: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(viewModel.items.count) NFT")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    
                    Text(viewModel.totalPriceText)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.greenUniversal)
                }
                
                Spacer()
                
                PrimaryButton(title: Constants.pay,
                              isEnabled: true) {
                    
                }
                              .frame(width: 240, height: 44)
                
            }
            .padding()
            .background(.lightGrayPrimary)
        }
    }
    
    // MARK: - EmptyStateView
    private var emptyStateView: some View {
        VStack {
            Spacer()
            Text(Constants.emptyCart)
                .font(.system(size: 17))
                .foregroundColor(.blackPrimary)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

private enum Constants {
    static let pay = NSLocalizedString("Pay", comment: "")
    static let emptyCart = NSLocalizedString("EmptyCart", comment: "")
    static let failed = NSLocalizedString("Error.network", comment: "")
    static let errorRepeat = NSLocalizedString("Error.repeat", comment: "")
    static let cancel = NSLocalizedString("Cancel", comment: "")
}

// MARK: - Preview
#Preview {
    CartView(viewModel: CartViewModel(service: MockCartService()))
}

#Preview {
    CartView(viewModel: CartViewModel(service: FailingCartService()))
}
