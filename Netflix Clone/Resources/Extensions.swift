//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 6/2/24.
//

import Foundation

extension String {
   func capitalizeFirstLetter() -> String {
      return self.prefix(1).uppercased() + self.lowercased().dropFirst()
   }
}
