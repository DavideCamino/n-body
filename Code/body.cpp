//
// Created by dadi on 3/19/24.
//

#include "body.h"


const vector3D &body::getPosition() const {
    return position;
}

void body::setPosition(const vector3D &position) {
    body::position = position;
}

const vector3D &body::getVelocity() const {
    return velocity;
}

void body::setVelocity(const vector3D &velocity) {
    body::velocity = velocity;
}

const vector3D &body::getAcceleration() const {
    return acceleration;
}

void body::setAcceleration(const vector3D &acceleration) {
    body::acceleration = acceleration;
}

double body::getMass() const {
    return mass;
}

void body::setMass(double mass) {
    body::mass = mass;
}

double body::getRadius() const {
    return radius;
}

void body::setRadius(double radius) {
    body::radius = radius;
}

body::body(const vector3D &position, const vector3D &velocity, double mass, double radius) : position(position),
                                                                                             velocity(velocity),
                                                                                             mass(mass),
                                                                                             radius(radius) {}

body::body(const vector3D &position, const vector3D &velocity, double mass) : position(position),
                                                                              velocity(velocity),
                                                                              mass(mass) {
    radius = 1;
}
