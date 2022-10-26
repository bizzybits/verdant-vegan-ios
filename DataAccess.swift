//
//  DataAccess.swift
//  verdantVegan2
//
//  Created by Elizabeth Ponce on 10/26/22.
//

import Foundation
import SQLite


class DataAccess {
    
    let id = Expression<Int64>("id")
    let title = Expression<String?>("title")
    let cuisine = Expression<String>("cuisine")
    let mainIngredient = Expression<String>("mainIngredient")
    
 //   func createRecipe(recipe: Recipe) -> Int64 {
//        do {
//            let db = try Connection(fileName())
//
//            let recipes = Table("recipes");
//
//            let rowId = try db.run(recipes.insert(
//                title <- recipe.title,
//                cuisine <- recipe.cuisine,
//                mainIngredient <- recipe.mainIngredient))
//
//            return rowId
//
//        } catch {
//            print("ERROR: \(error)")
//        }
//        return -1
//    }
    
    func fileName() -> String {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        let name = "\(path)/db.sqlite3";
        return name;
    }
    
    func initTables() {
        do {
            let db = try Connection(fileName())
            
            try initRecipesTable(db: db)
            
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    func dropTables() {
        do {
            let db = try Connection(fileName())
            
            let recipes = Table("recipes");
            try db.run(recipes.drop(ifExists: true));
            
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    private func initRecipesTable(db: Connection) throws {
        let recipes = Table("recipes")
        let id = Expression<Int64>("id")
        let title = Expression<String?>("title")
        let cuisine = Expression<String>("cuisine")
        let mainIngredient = Expression<String>("mainIngredient")

        try db.run(recipes.create { t in
            t.column(id, primaryKey: true)
            t.column(title)
            t.column(cuisine)
            t.column(mainIngredient)
        })
    }
}
