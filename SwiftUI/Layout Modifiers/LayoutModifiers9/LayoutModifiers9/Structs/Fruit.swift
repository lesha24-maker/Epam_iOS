//
//  Fruit.swift
//  LayoutModifiers9
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI


struct Fruit: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let description: String
    let color: Color
    let nutritionalInfo: String
}

struct FruitData {
    static let allFruits: [Fruit] = [
        Fruit(
            name: "Apple",
            emoji: "🍎",
            description: "A crisp and juicy fruit, apples come in a variety of colors and flavors, from sweet to tart. They are one of the most widely cultivated tree fruits.",
            color: .red,
            nutritionalInfo: "Apples are a good source of fiber and vitamin C. A medium-sized apple contains about 95 calories."
        ),
        Fruit(
            name: "Banana",
            emoji: "🍌",
            description: "Known for their high potassium content, bananas are a sweet, soft fruit enclosed in a yellow peel. They are a staple food in many tropical countries.",
            color: .yellow,
            nutritionalInfo: "Bananas are rich in potassium and vitamin B6. A medium-sized banana has around 105 calories."
        ),
        Fruit(
            name: "Cherry",
            emoji: "🍒",
            description: "Cherries are small, round, and typically deep red stone fruits. They can be sweet or sour and are often used in desserts, jams, and drinks.",
            color: .red,
            nutritionalInfo: "Cherries are packed with antioxidants and anti-inflammatory compounds. A cup of cherries has about 97 calories."
        ),
        Fruit(
            name: "Grape",
            emoji: "🍇",
            description: "Grapes grow in clusters on vines and can be green, red, or purple. They are eaten fresh or used for making wine, jam, juice, and raisins.",
            color: .purple,
            nutritionalInfo: "Grapes are a good source of vitamins C and K. A cup of grapes contains about 104 calories."
        ),
        Fruit(
            name: "Orange",
            emoji: "🍊",
            description: "A citrus fruit known for its vibrant color and high vitamin C content. Oranges have a tough, oily peel and juicy, sweet-tart flesh.",
            color: .orange,
            nutritionalInfo: "Oranges are an excellent source of vitamin C and folate. A medium-sized orange has about 62 calories."
        )
    ]
}
