//
//  ButtonStyles.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/12.
//

import SwiftUI

struct grayClickStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
          .background(configuration.isPressed ?
          .gray.opacity(0.36) :
          .clear)
  }
}
