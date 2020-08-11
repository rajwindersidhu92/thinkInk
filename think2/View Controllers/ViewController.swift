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
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func add(_ sender: Any) {
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        let x = randomNumber(firstNumber: -0.3, secNumber: 0.3)
        let y = randomNumber(firstNumber: -0.3, secNumber: 0.3)
        let z = randomNumber(firstNumber: -0.3, secNumber: 0.3)
        node.position = SCNVector3(x,y,z)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    @IBAction func resetSession(_ sender: Any) {
        self.resset()
        
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

