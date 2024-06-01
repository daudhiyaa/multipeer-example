//
//  ListPairView.swift
//  MultipeerExample
//
//  Created by Daud on 30/05/24.
//

import SwiftUI

struct ListPairView: View {
    @EnvironmentObject var multipeerSession: ExampleMultipeerSession

    @Binding var isSheetPresented: Bool
        
    var body: some View {
        VStack{
            if (!multipeerSession.paired) {
                HStack {
                    List(multipeerSession.availablePeers, id: \.self) { peer in
                        Button(peer.displayName) {
                            multipeerSession.serviceBrowser.invitePeer(peer, to: multipeerSession.session, withContext: nil, timeout: 30)
                        }
                    }
                }
                .alert("Received an invite from \(multipeerSession.recvdInviteFrom?.displayName ?? "ERR")!", isPresented: $multipeerSession.recvdInvite) {
                    Button("Accept invite") {
                        if (multipeerSession.invitationHandler != nil) {
                            multipeerSession.invitationHandler!(true, multipeerSession.session)
                        }
                    }
                    Button("Reject invite") {
                        if (multipeerSession.invitationHandler != nil) {
                            multipeerSession.invitationHandler!(false, nil)
                        }
                    }
                }
            } else {
                List {
                    HStack {
                        Text("Connected: '\(multipeerSession.session.connectedPeers[0].displayName)'")
                        Spacer()
                        Button("Send Plant") {
                            multipeerSession.sendPlant(plant: listOfPlants[Int.random(in: 0..<listOfPlants.count)])
                            isSheetPresented = false
                        }
                    }
                }
                
                // List(multipeerSession.availablePeers, id: \.self) { peer in
                //     Text("\(peer.displayName)")
                // }
                // GameView(currentView: $currentView).environmentObject(multipeerSession)
            }
        }
        .textInputAutocapitalization(.never).disableAutocorrection(true)
        .navigationBarTitle("List Active Device", displayMode: .inline)
        .navigationBarItems(
            trailing:Button("Cancel"){
                isSheetPresented = false
            }.foregroundColor(.red)
        )
    }
}
