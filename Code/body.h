//
// Created by dadi on 3/19/24.
//

#ifndef N_BODY_BODY_H
#define N_BODY_BODY_H


#include "vector3D.h"

class body {

private:
    vector3D position;
    vector3D velocity;
    vector3D acceleration;
    double mass;
    double radius;

public:

    const vector3D &getPosition() const;

    void setPosition(const vector3D &position);

    const vector3D &getVelocity() const;

    void setVelocity(const vector3D &velocity);

    const vector3D &getAcceleration() const;

    void setAcceleration(const vector3D &acceleration);

    double getMass() const;

    void setMass(double mass);

    double getRadius() const;

    void setRadius(double radius);

    body(const vector3D &position, const vector3D &velocity, double mass, double radius);

    body(const vector3D &position, const vector3D &velocity, double mass);
};


#endif //N_BODY_BODY_H
