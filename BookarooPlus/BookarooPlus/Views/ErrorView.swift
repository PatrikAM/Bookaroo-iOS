//
//  ErrorView.swift
//  BookarooPlus
//
//  Created by Marek Glas on 22.01.2024.
//

import SwiftUI

struct ErrorView: View {
    
    var onRetryButtonClick: () -> Void
    
    var errorMessageIdentifier: String
    
    var body: some View {
        VStack {
            if (errorMessageIdentifier  == APIErrorsConstants.badStatusCode.rawValue) {
                Text("Incorrect login credentials. Please tap the retry button. If it doesn't work, try logging out and back in.")
                Spacer()
                    .frame(height: 30)
                Image(AssetsConstants.fingerprintLoginIcon.rawValue)
                    .resizable()
                    .frame(width: 270)
            } else if (errorMessageIdentifier  == APIErrorsConstants.loginFailed.rawValue) {
                Text("Encountered an issue logging in. Please launch the app again and log in if it's required.")
                Spacer()
                    .frame(height: 30)
                Image(AssetsConstants.fingerprintLoginIcon.rawValue)
                    .resizable()
                    .frame(width: 270)
            } else if (errorMessageIdentifier == APIErrorsConstants.badUrl.rawValue) {
                Text("Could not reach the server. Please tap the retry button or relaunch the app.")
                Spacer()
                    .frame(height: 30)
                Image(AssetsConstants.serverDownIcon.rawValue)
                    .resizable()
                    .frame(width: 270)
            } else if (errorMessageIdentifier == APIErrorsConstants.invalidRequest.rawValue) {
                Text("There was an issue while downloading data. Please tap the retry button.")
                Spacer()
                    .frame(height: 30)
                Image(AssetsConstants.bugHuntIcon.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 270)
            } else if (errorMessageIdentifier == APIErrorsConstants.failedToDecodeResponse.rawValue) {
                Text("There was an issue while trying to read your data. Please tap the retry button.")
                Spacer()
                    .frame(height: 30)
                Image(AssetsConstants.fixingBugsIcon.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 270)
            } else {
                Text("The application encountered an unknown error. Please tap the retry button or restart the app.")
                Spacer()
                    .frame(height: 30)
                Image(AssetsConstants.bugHuntIcon.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 270)
            }
            
            Spacer()
                .frame(height: 100)
            
            Button(action: {
                onRetryButtonClick()
            }, label: {
                Image(systemName: "arrow.counterclockwise")
                Text("Retry")
            })
            .buttonStyle(.borderedProminent)
        }
        .padding(.all)
    }
}
