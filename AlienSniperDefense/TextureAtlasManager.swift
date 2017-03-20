//
//  TextureAtlasManager.swift
//  AlienSniperDefense
//
//  Created by Aleksander Makedonski on 3/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit

class TextureAtlasManager{
    
    static public let sharedInstance = TextureAtlasManager()
    
    enum TextureAtlasType{
        case BackgroundObjects
        case RegularExplosion
        case FlyingAliens
        case Enemies
        case HUD
        case CrossHair
        case UI
        case SpaceShips
        case UFO
        case Bats
        case Medals
    }
    
    func getTextureAtlasOfType(textureAtlasType: TextureAtlasType) -> SKTextureAtlas?{
        
        
        
        switch(textureAtlasType)
        {
        case .CrossHair:
            return crosshairAtlas
        case .Enemies:
            return enemiesAtlas
        case .HUD:
            return hudAtlas
        case .BackgroundObjects:
            return backgroundObjectsAtlas
        case .RegularExplosion:
            return regularExplosionAtlas
        case .FlyingAliens:
            return flyingAliensAtlas
        case .UFO:
            return ufoAtlas
        case .UI:
            return userInterfaceAtlas
        case .SpaceShips:
            return spaceShipsAtlas
        case .Bats:
            return batsAtlas
        case .Medals:
            return medalsAtlas
        
            
        }
    }
    
    private var crosshairAtlas: SKTextureAtlas?
    private var enemiesAtlas: SKTextureAtlas?
    private var hudAtlas: SKTextureAtlas?
    private var flyingAliensAtlas: SKTextureAtlas?
    private var regularExplosionAtlas: SKTextureAtlas?
    private var backgroundObjectsAtlas: SKTextureAtlas?
    private var ufoAtlas: SKTextureAtlas?
    private var userInterfaceAtlas: SKTextureAtlas?
    private var spaceShipsAtlas: SKTextureAtlas?
    private var batsAtlas: SKTextureAtlas?
    private var medalsAtlas: SKTextureAtlas?
    
    private init(){
        setup()
    }
    
    private func setup(){
        crosshairAtlas = SKTextureAtlas(named: "CrossHair.atlas")
        enemiesAtlas = SKTextureAtlas(named: "Enemies.atlas")
        batsAtlas = SKTextureAtlas(named: "Bats.atlas")
        hudAtlas = SKTextureAtlas(named: "HUD.atlas")
        flyingAliensAtlas = SKTextureAtlas(named: "FlyingAliens.atlas")
        regularExplosionAtlas = SKTextureAtlas(named: "RegularExplosion.atlas")
        backgroundObjectsAtlas = SKTextureAtlas(named: "BackgroundObjects.atlas")
        ufoAtlas = SKTextureAtlas(named: "UFO.atlas")
        userInterfaceAtlas = SKTextureAtlas(named: "UI.atlas")
        spaceShipsAtlas = SKTextureAtlas(named: "SpaceShips.atlas")
        medalsAtlas = SKTextureAtlas(named: "Medals.atlas")
    }
    
}
