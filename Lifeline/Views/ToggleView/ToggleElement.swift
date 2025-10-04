//
//  ToggleElement.swift
//  Lifeline
//
//  Created by Vlad on 04/10/2025.
//

import SwiftUI

protocol ToggleElement: Identifiable, Hashable {
    var name: String { get }
    var systemImage: String { get }
    var imageColor: Color { get }
}
