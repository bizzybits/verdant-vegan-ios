//
//  RecipeModel.swift
//  verdantVegan2
//
//  Created by Elizabeth Ponce on 10/26/22.
//

import Foundation

class RecipeModel : Identifiable {
    public var id: Int64 = 0
    public var title: String = ""
    public var cuisine: String = ""
    public var mainIngredient: String = ""
}
