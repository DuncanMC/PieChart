# PieChart
A sample iOS app written in swift that generates pie charts.

This program demonstrates a number of techniques, both in using the Swift language and using UIKit and Core Animation.

It defines a structure Slice which describes a single slice of a pie chart:
    struct Slice
    {
      var radius: CGFloat
      var width:  CGFloat
      init(
        radius:     CGFloat = 1.0,
        width:      CGFloat = 0.125
        )
      {
        self.radius = radius
        self.width = width
      }
    }

Both the radius and width settings define default values, so you can create a slice object with 

    Slice()
    Slice(radius: 1.0)
    Slice(width: 1.0)
Or
    Slice(radius: 0.2 width: .5)
