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
    

The class PieChartView, a subclass of UIView, does most of the work.

It has a property `slices: [Slice]` that is an array of Slice objects.

The slices property of the PieChartView has a didSet property obserer, so when you change the slices array, the view updates the pie chart to reflect the changes.

The pie chart graph is drawn using a CAShapeLayer attached to the view.
The PieChartView creates a UIBezierPath that contains "pie wedge" shapes for each slice in the graph.

It then installs the CGPath from the UIBezierPath into the path property of the view's UIShapeLayer.

If you change the values int the slices array without changing the number of elements, the PieChartView animates the changes to the graph by creating a CABasicAnimation that animate the change to the CAShapeLayer's path property.

Animating a CAShapeLayer's path property only works properly if the starting and ending path have the same number and type of control points.