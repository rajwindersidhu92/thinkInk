//
//  ViewController.swift
//  think2
//
//  Created by Udhay on 2020-07-21.
//  Copyright © 2020 Udhay. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    var passText = ""
    
    
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    var count = 0
    var pointX = CGFloat()
    var pointY = CGFloat()
    var tattooNode = SCNNode()

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("herree")
//        print(passText)
        pointY = 0
        pointX = 0
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: sceneView)
                pointX = location.x
                pointY = location.y
            print(pointX)
            print(pointY)
        }
    }
    
    @IBAction func add(_ sender: Any) {
        let final = passText+".dae"
        
        let tattooScene = SCNScene(named: final)!
        //var x = randomNumber(firstNumber: 0, secNumber: 0.3)
        //var y = randomNumber(firstNumber: 0, secNumber: 0.3)
        let z = randomNumber(firstNumber: 0, secNumber: 0.1)
        if count == 0 {
            tattooNode = tattooScene.rootNode.childNodes.first!
            count = count + 1
            pointX = 0.1
            pointY = 0.1
            tattooNode.geometry?.firstMaterial?.diffuse.contents = UIColor(white: 0, alpha: 1)
            tattooNode.position = SCNVector3(pointX,pointY,z)
            self.sceneView.scene.rootNode.addChildNode(tattooNode)
        }
        else {
            self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
                tattooNode.removeFromParentNode()
            }
            count = 0
        }
    }
    
    
    
    @IBAction func resetSession(_ sender: Any) {
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            tattooNode.removeFromParentNode()
        }
        
    }
    
    func addTattoo(x: CGFloat, y: CGFloat, z: CGFloat){
        
    }
    
    func resset() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node,_) in node.removeFromParentNode()}
        self.sceneView.session.run(configuration, options: [.resetTracking,.removeExistingAnchors])
    }
    func randomNumber(firstNumber: CGFloat , secNumber: CGFloat ) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNumber - secNumber) + min(firstNumber,secNumber)
    }
    
}

