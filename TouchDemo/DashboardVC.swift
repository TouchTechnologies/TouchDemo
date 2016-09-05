//
//  DashboardVC.swift
//  TouchDemo
//
//  Created by Thirawat Phannet on 1/9/59.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit
//import Foundation
import AudioToolbox
import FontAwesome_swift

import SwiftCharts

class DashboardVC: UIViewController, ProximityContentManagerDelegate, UIGestureRecognizerDelegate {
    
    private var chart: Chart? // arc
    
    var proximityContentManager: ProximityContentManager!
    var w = CGFloat(),h = CGFloat()
    var hsplit = CGFloat()
    let viewForChart = UIView()
    
    func design() {
        
        w = self.view.frame.size.width
        h = self.view.frame.size.height
        hsplit = h / 2
//        let testView = UIView(frame: CGRectMake(0, 0, w, 80))
//        //        testView.backgroundColor = UIColor
//        testView.backgroundColor = SWColor(hexString: "#eeff00")
//        self.view.addSubview(testView)
        
        
        viewForChart.frame = CGRectMake(0, 0, w, hsplit)
        viewForChart.clipsToBounds = true
        viewForChart.layer.borderColor = UIColor.blueColor().CGColor
        viewForChart.layer.borderWidth = 0.5
        self.view.addSubview(viewForChart)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        loadChart()
//        self.tabBarController?.tabBar.barTintColor = UIColor.whiteColor()
//        tabItem.image = UIImage.fontAwesomeIconWithName(.Home, textColor: UIColor.blackColor(), size: CGSizeMake(50, 50))
//        
//        let testView = UIView(frame: CGRectMake(20, 20, 200, 30))
////        testView.backgroundColor = UIColor
//        testView.backgroundColor = SWColor(hexString: "#eeaaaa")
//        self.view.addSubview(testView)
        
        
        
        self.proximityContentManager = ProximityContentManager(
            beaconIDs: [
                BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE01", major: 4225, minor: 21861), //mint
                BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE02", major: 62648, minor: 16128),//ice
                BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE03", major: 20999, minor: 49007) //blueberry
            ],
            beaconContentFactory: CachingContentFactory(beaconContentFactory: BeaconDetailsCloudFactory()))
        self.proximityContentManager.delegate = self
        self.proximityContentManager.startContentUpdates()
    }
    
    func proximityContentManager(proximityContentManager: ProximityContentManager, didUpdateContent content: AnyObject?) {

        if let beaconDetails = content as? BeaconDetails {
            
            
            switch beaconDetails.beaconName {
            case "mint":
                //bannerSet = 1
                break
            case "blueberry":
                //bannerSet = 2
                break
            case "ice":
                //bannerSet = 3
                break
            default:
                break
                
            }
            
        } else {
            
            //closeBanner() // ไม่ต้องปิดแล้ว จนกว่าผู้ใช้จะปิดเอง
            
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    func loadChart() {
        
//        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
//        
//        let chartPoints = [(2, 2), (4, 4), (7, 1), (8, 11), (12, 3)].map{ChartPoint(x: ChartAxisValueDouble($0.0, labelSettings: labelSettings), y: ChartAxisValueDouble($0.1))}
//        
//        let xValues = chartPoints.map{$0.x}
//        
//        let yValues = ChartAxisValuesGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 10, maxSegmentCount: 20, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
//        
//        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
//        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical()))
//        let chartFrame = ExamplesDefaults.chartFrame(viewForChart.bounds)
//        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: ExamplesDefaults.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
//        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
//        
//        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.redColor(), animDuration: 1, animDelay: 0)
//        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
//        
//        
//        let trackerLayerSettings = ChartPointsLineTrackerLayerSettings(thumbSize: Env.iPad ? 30 : 20, thumbCornerRadius: Env.iPad ? 16 : 10, thumbBorderWidth: Env.iPad ? 4 : 2, infoViewFont: ExamplesDefaults.fontWithSize(Env.iPad ? 26 : 16), infoViewSize: CGSizeMake(Env.iPad ? 400 : 160, Env.iPad ? 70 : 40), infoViewCornerRadius: Env.iPad ? 30 : 15)
//        let chartPointsTrackerLayer = ChartPointsLineTrackerLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, lineColor: UIColor.blackColor(), animDuration: 1, animDelay: 2, settings: trackerLayerSettings)
//        
//        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth)
//        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
//        
//        let chart = Chart(
//            frame: chartFrame,
//            layers: [
//                xAxis,
//                yAxis,
//                guidelinesLayer,
//                chartPointsLineLayer,
//                chartPointsTrackerLayer
//            ]
//        )
        
        
        
        
        
        
        
//        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
//        
//        let chartPoints: [ChartPoint] = [(1, 3), (2, 5),(3, 5),(4, 5), (5, 7.5), (6, 10), (7, 6), (8, 12)].map{ChartPoint(x: ChartAxisValueDouble($0.0, labelSettings: labelSettings), y: ChartAxisValueDouble($0.1))}
//        
//        let xValues = chartPoints.map{$0.x}
//        let yValues = ChartAxisValuesGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 10, maxSegmentCount: 20, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
//        
//        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.redColor(), animDuration: 1, animDelay: 0)
//        
//        let trendLineModel = ChartLineModel(chartPoints: TrendlineGenerator.trendline(chartPoints), lineColor: UIColor.blueColor(), animDuration: 0.5, animDelay: 1)
//        
//        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
//        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical()))
//        let chartFrame = ExamplesDefaults.chartFrame(viewForChart.bounds)
//        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: ExamplesDefaults.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
//        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
//        
//        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
//        
//        let trendLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [trendLineModel])
//        
//        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth)
//        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
//        
//        let chart = Chart(
//            frame: chartFrame,
//            layers: [
//                xAxis,
//                yAxis,
//                guidelinesLayer,
//                chartPointsLineLayer,
//                trendLineLayer
//            ]
//        )

        
        
        
        
        
        
        
//        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
//        
//        let chartPoints = [(2, 2), (3, 1), (5, 9), (6, 7), (8, 10), (9, 9), (10, 15), (13, 8), (15, 20), (16, 17)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
//        
//        let xValues = ChartAxisValuesGenerator.generateXAxisValuesWithChartPoints(chartPoints, minSegmentCount: 7, maxSegmentCount: 7, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
//        let yValues = ChartAxisValuesGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 10, maxSegmentCount: 20, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: true)
//        
//        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
//        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical()))
//        let chartFrame = ExamplesDefaults.chartFrame(viewForChart.bounds)
//        
//        let chartSettings = ExamplesDefaults.chartSettings
//        chartSettings.trailing = 20
//        chartSettings.labelsToAxisSpacingX = 15
//        chartSettings.labelsToAxisSpacingY = 15
//        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
//        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
//        
//        let showCoordsTextViewsGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
//            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
//            let w: CGFloat = 70
//            let h: CGFloat = 30
//            
//            let text = "(\(chartPoint.x), \(chartPoint.y))"
//            let font = ExamplesDefaults.labelFont
//            let textSize = ChartUtils.textSize(text, font: font)
//            let x = min(screenLoc.x + 5, chart.bounds.width - textSize.width - 5)
//            let view = UIView(frame: CGRectMake(x, screenLoc.y - h, w, h))
//            let label = UILabel(frame: view.bounds)
//            label.text = "(\(chartPoint.x), \(chartPoint.y))"
//            label.font = ExamplesDefaults.labelFont
//            view.addSubview(label)
//            view.alpha = 0
//            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
//                view.alpha = 1
//                }, completion: nil)
//            return view
//        }
//        
//        let showCoordsLinesLayer = ChartShowCoordsLinesLayer<ChartPoint>(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints)
//        let showCoordsTextLayer = ChartPointsSingleViewLayer<ChartPoint, UIView>(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: showCoordsTextViewsGenerator)
//        
//        let touchViewsGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
//            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
//            let s: CGFloat = 30
//            let view = HandlingView(frame: CGRectMake(screenLoc.x - s/2, screenLoc.y - s/2, s, s))
//            view.touchHandler = {[weak showCoordsLinesLayer, weak showCoordsTextLayer, weak chartPoint, weak chart] in
//                guard let chartPoint = chartPoint, chart = chart else {return}
//                showCoordsLinesLayer?.showChartPointLines(chartPoint, chart: chart)
//                showCoordsTextLayer?.showView(chartPoint: chartPoint, chart: chart)
//            }
//            return view
//        }
//        
//        let touchLayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: touchViewsGenerator)
//        
//        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor(red: 0.4, green: 0.4, blue: 1, alpha: 0.2), lineWidth: 3, animDuration: 0.7, animDelay: 0)
//        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
//        
//        let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
//            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 24)
//            circleView.animDuration = 1.5
//            circleView.fillColor = UIColor.whiteColor()
//            circleView.borderWidth = 5
//            circleView.borderColor = UIColor.blueColor()
//            return circleView
//        }
//        let chartPointsCircleLayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: circleViewGenerator, displayDelay: 0, delayBetweenItems: 0.05)
//        
//        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth)
//        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
//        
//        
//        let chart = Chart(
//            frame: chartFrame,
//            layers: [
//                xAxis,
//                yAxis,
//                guidelinesLayer,
//                showCoordsLinesLayer,
//                chartPointsLineLayer,
//                chartPointsCircleLayer,
//                showCoordsTextLayer,
//                touchLayer,
//                
//            ]
//        )

        
        
        
        
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let chartPoints0 = [
            self.createChartPoint(2, 2, labelSettings),
            self.createChartPoint(4, -4, labelSettings),
            self.createChartPoint(7, 1, labelSettings),
            self.createChartPoint(8.3, 11.5, labelSettings),
            self.createChartPoint(9, 15.9, labelSettings),
            self.createChartPoint(10.8, 3, labelSettings),
            self.createChartPoint(13, 24, labelSettings),
            self.createChartPoint(15, 0, labelSettings),
            self.createChartPoint(17.2, 2, labelSettings),
            self.createChartPoint(20, 10, labelSettings),
            self.createChartPoint(22.3, 10, labelSettings),
            self.createChartPoint(27, 15, labelSettings),
            self.createChartPoint(30, 6, labelSettings),
            self.createChartPoint(40, 10, labelSettings),
            self.createChartPoint(50, 2, labelSettings),
            ]
        
        let chartPoints1 = [
            self.createChartPoint(2, 5, labelSettings),
            self.createChartPoint(3, 7, labelSettings),
            self.createChartPoint(5, 9, labelSettings),
            self.createChartPoint(8, 6, labelSettings),
            self.createChartPoint(9, 10, labelSettings),
            self.createChartPoint(10, 20, labelSettings),
            self.createChartPoint(12, 19, labelSettings),
            self.createChartPoint(13, 20, labelSettings),
            self.createChartPoint(14, 25, labelSettings),
            self.createChartPoint(16, 28, labelSettings),
            self.createChartPoint(17, 15, labelSettings),
            self.createChartPoint(19, 6, labelSettings),
            self.createChartPoint(25, 3, labelSettings),
            self.createChartPoint(30, 10, labelSettings),
            self.createChartPoint(45, 15, labelSettings),
            self.createChartPoint(50, 20, labelSettings),
            ]
        
        let xValues = 2.stride(through: 50, by: 1).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)}
        let yValues = ChartAxisValuesGenerator.generateYAxisValuesWithChartPoints(chartPoints0, minSegmentCount: 10, maxSegmentCount: 20, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings.defaultVertical()))
        let scrollViewFrame = ExamplesDefaults.chartFrame(viewForChart.bounds)
        let chartFrame = CGRectMake(0, 0, 1400, scrollViewFrame.size.height)
        
        // calculate coords space in the background to keep UI smooth
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: ExamplesDefaults.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
            
            dispatch_async(dispatch_get_main_queue()) {
                let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
                
                let lineModel0 = ChartLineModel(chartPoints: chartPoints0, lineColor: UIColor.redColor(), animDuration: 1, animDelay: 0)
                let lineModel1 = ChartLineModel(chartPoints: chartPoints1, lineColor: UIColor.blueColor(), animDuration: 1, animDelay: 0, dashPattern: [5,10])
                let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel0, lineModel1])
                
                let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth)
                let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
                
                let scrollView = UIScrollView(frame: scrollViewFrame)
                scrollView.contentSize = CGSizeMake(chartFrame.size.width, scrollViewFrame.size.height)
                //        self.automaticallyAdjustsScrollViewInsets = false // nested view controller - this is in parent
                
                let chart = Chart(
                    frame: chartFrame,
                    layers: [
                        xAxis,
                        yAxis,
                        guidelinesLayer,
                        chartPointsLineLayer
                    ]
                )
                
                scrollView.addSubview(chart.view)
                
                self.viewForChart.addSubview(chart.view)
                self.chart = chart
                
            }
        }
        
//        
//        viewForChart.addSubview(chart.view)
//        self.chart = chart
    }
    
    
    private func createChartPoint(x: Double, _ y: Double, _ labelSettings: ChartLabelSettings) -> ChartPoint {
        return ChartPoint(x: ChartAxisValueDouble(x, labelSettings: labelSettings), y: ChartAxisValueDouble(y))
    }
    
}

