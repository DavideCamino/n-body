//
// Created by dadi on 3/19/24.
//

#include "solarSystem.h"

solarSystem::solarSystem() {
    /*system.push_back(sun);
    system.push_back(heart);
    system.push_back(negHeart);
    system.push_back(zHeart);
    system.push_back(zNegHeart);*/

    system.push_back(c1);
    system.push_back(c3);
    system.push_back(c2);

}

body& solarSystem::getBody(int index) {
    return system.at(index);
}

int solarSystem::getSize() const {
    return system.size();
}
