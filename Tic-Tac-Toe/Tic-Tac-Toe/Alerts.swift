//
//  Alerts.swift
//  Tic-Tac-Toe
//
//  Created by Cam on 8/6/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}


struct AlertContext {
    static let humanWin    = AlertItem(title: Text("You Win!"), message: Text("Your Amazing"), buttonTitle: Text("Hell yeah"))
    static let ComputerWin    = AlertItem(title: Text("You Lost"), message: Text("Computers are better"), buttonTitle: Text("Rematch"))
    static let draw    = AlertItem(title: Text("DRAW"), message: Text("No Winners"), buttonTitle: Text("Try Again"))
}
