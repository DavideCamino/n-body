//
// Created by dadi on 3/19/24.
//

#ifndef N_BODY_SOLAR_SYSTEM_H
#define N_BODY_SOLAR_SYSTEM_H


#include <vector>
#include <cmath>
#include "body.h"

#define G (1)
#define M_SUN (1.9885e30)

class solarSystem {

private:
    body sun = body(vector3D(0,0,0), vector3D(0,0,0), M_SUN);
    body heart = body(vector3D(0,152097597e3,0), vector3D(std::sqrt(G * M_SUN / 152097597e3),0,0), 5.972168e24);
    body negHeart = body(vector3D(0,-152097597e3,0), vector3D(-std::sqrt(G * M_SUN / 152097597e3),0,0), 5.972168e24);
    body zHeart = body(vector3D(0,0,152097597e3), vector3D(0, std::sqrt(G * M_SUN / 152097597e3),0), 5.972168e24);
    body zNegHeart = body(vector3D(0,0,-152097597e3), vector3D(0, -std::sqrt(G * M_SUN / 152097597e3),0), 5.972168e24);
    body c1 = body(vector3D(-0.97000436, 0.24308753, 0), vector3D(0.4662036850, 0.4323657300,0), 1);
    body c2 = body(vector3D(-0, 0, 0), vector3D(-0.93240737, -0.86473146,0), 1);
    body c3 = body(vector3D(0.97000436, -0.24308753, 0), vector3D(0.4662036850, 0.4323657300,0), 1);
    std::vector<body> system;

public:
    solarSystem();

    body& getBody(int index);

    int getSize() const;
};


#endif //N_BODY_SOLAR_SYSTEM_H
