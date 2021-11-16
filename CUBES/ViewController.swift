//
//  ViewController.swift
//  CUBES
//
//  Created by Maxim Mitin on 16.11.21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var minHeight: CGFloat = 0.2
    var maxHeight: CGFloat = 0.7
    var minDispersal: CGFloat = -4
    var maxDispersal: CGFloat = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    
    @IBAction func addCubeClicked(_ sender: Any) {
        generateCube()
    }
    
    //MARK: - Randomizers for objects
    
    func generateRandomVector() -> SCNVector3 {
        return SCNVector3(CGFloat.random(in: minDispersal...maxDispersal), CGFloat.random(in: minDispersal...maxDispersal), CGFloat.random(in: minDispersal...maxDispersal))
    }
    
    func generateRandomColor() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0...1),
                       green: CGFloat.random(in: 0...1),
                       blue: CGFloat.random(in: 0...1),
                       alpha: CGFloat.random(in: 0.4...1))
    }
    
    func generateRandomSize() -> CGFloat {
        return CGFloat.random(in: minHeight...maxHeight)
    }
    
    func generateCube() {
        let size = generateRandomSize()
        let cube = SCNBox(width: size, height: size, length: size, chamferRadius: 0.03)
        
        cube.materials.first?.diffuse.contents = generateRandomColor()
        
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = generateRandomVector()
        
        let rotateAction = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 3)
        let repeatAction = SCNAction.repeatForever(rotateAction)
        cubeNode.runAction(repeatAction)
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
        
    }
    
}
