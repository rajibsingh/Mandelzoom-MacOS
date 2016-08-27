
Mandelzoom
==========

![Current Rendering](http://i.imgur.com/okg2sYt.png)

refer to the classic [article](https://www.scientificamerican.com/media/inline/blog/File/Dewdney_Mandelbrot.pdf) by AK Dewdney for the Mathematical Recreations column of the Scientific American. 

learning MacOS development and Swift to put together a viewer for the mandelbrot set.


# completed
* initial view

# upcoming
* panning
* zooming
* smoothing - Gaussian blur?
* performance - currently running at 


# performance
### June 18 first cut 
> [Mandelzoom_MacOSTests.Mandelzoom_MacOSTests testPerformanceExample]' measured [Time, seconds] average: 26.145, relative standard deviation: 2.473%, values: [26.288928, 26.485824, 25.497683, 26.386562, 25.257380, 26.178977, 25.184972, 25.971432, 27.169229, 27.026746], performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, baselineName: "", baselineAverage: , maxPercentRegression: 10.000%, maxPercentRelativeStandardDeviation: 10.000%, maxRegression: 0.100, maxStandardDeviation: 0.100
### June 19 adding some mouse eventing code
> [Mandelzoom_MacOSTests.Mandelzoom_MacOSTests testPerformanceExample]' measured [Time, seconds] average: 26.342, relative standard deviation: 1.557%, values: [26.449139, 26.853080, 26.664213, 26.922974, 26.690608, 26.224376, 25.989110, 25.725439, 26.061260, 25.841773], performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, baselineName: "", baselineAverage: , maxPercentRegression: 10.000%, maxPercentRelativeStandardDeviation: 10.000%, maxRegression: 0.100, maxStandardDeviation: 0.100


