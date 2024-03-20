#include <iostream>
#include <fstream>
#include "solarSystem.h"

#define TIME_STEP (0.01)
#define TIME_LIMIT (100)
//#define TIME_LIMIT (6*60*60)


void updatePosition(solarSystem& solar);
void updateAcc(solarSystem& solar);
void updateVel(solarSystem& solar);
void calcAcc(body& b1, body& b2);
void update(solarSystem& solar);
void printLog(solarSystem& solar, int epoch);

int main() {
    solarSystem solar = solarSystem();
    for(int i = 0; i < TIME_LIMIT / TIME_STEP; i++) {
        update(solar);
        if(i % 5 == 0)
            printLog(solar, i);
    }
    return 0;
}

void update(solarSystem& solar) {
    updateAcc(solar);
    updatePosition(solar);
    updateVel(solar);
}

void updateAcc(solarSystem& solar) {
    for(int i = 0; i < solar.getSize(); i++) {
        solar.getBody(i).setAcceleration(vector3D());
    }
    for(int i = 0; i < solar.getSize(); i++) {
        for(int j = i+1; j < solar.getSize(); j++) {
            body& body1 = solar.getBody(i);
            body& body2 = solar.getBody(j);
            calcAcc(body1, body2);
            std::cout << "acc post body " << i << " = " << body1.getAcceleration() << std::endl;
            std::cout << "acc post body " << j << " = " << body2.getAcceleration() << std::endl;
        }
    }
}

void calcAcc(body& b1, body& b2) {
    vector3D distance12 = b2.getPosition() - b1.getPosition();
    double factor1 = +G * b2.getMass() / distance12.magnitude() / distance12.magnitude();
    double factor2 = -G * b1.getMass() / distance12.magnitude() / distance12.magnitude();
    std::cout<<"p1=" << b1.getPosition()<<std::endl;
    std::cout<<"p2=" << b2.getPosition()<<std::endl;
    std::cout<<"dist=" << distance12<<std::endl;
    std::cout << "factor = " << G << "*" << b2.getMass() << "/" << distance12.magnitude() << "/" << distance12.magnitude() << std::endl;
    std::cout << "acc pre " << b1.getAcceleration() << std::endl;
    std::cout << "acc add " << distance12.versor() * factor1 << std::endl;
    //std::cout << "acc pre " << b2.getAcceleration() << std::endl;
    b1.setAcceleration(b1.getAcceleration() + distance12.versor() * factor1);
    b2.setAcceleration(b2.getAcceleration() + distance12.versor() * factor2);
    std::cout << "acc post " << b1.getAcceleration() << std::endl;

}

void updatePosition(solarSystem& solar) {
    for(int i = 0; i < solar.getSize(); i++) {
        body& b = solar.getBody(i);
        std::cout << "pos pre "<< i << " " << b.getPosition() << std::endl;

        std::cout <<b.getPosition() <<"+" <<b.getVelocity()<< "*"<< TIME_STEP<< "+"  <<b.getAcceleration()<< "*"<< 0.5<< "*"<< TIME_STEP<< "*"<< TIME_STEP <<std::endl;
        b.setPosition(b.getPosition() + b.getVelocity() * TIME_STEP +  b.getAcceleration() * 0.5 * TIME_STEP * TIME_STEP);
        std::cout << "pos post "<< i << " " << b.getPosition() << std::endl;
        std::cout << "pos post magnitude"<< i << " " << b.getPosition().magnitude() << std::endl;
    }
}

void updateVel(solarSystem& solar) {
    for(int i = 0; i < solar.getSize(); i++) {
        body& b = solar.getBody(i);
        std::cout << "vel pre "<< i << " " << b.getVelocity() << std::endl;
        b.setVelocity(b.getVelocity() + b.getAcceleration() * TIME_STEP);
        std::cout << "vel post " << i << " " << b.getVelocity() << std::endl;
    }
}

void printLog(solarSystem& solar, int epoch) {
    std::ofstream logfile("logfile.txt", std::ios::app);
    for (int i = 0; i < solar.getSize(); i++) {
        logfile << solar.getBody(i).getPosition().toCSV();
        if(i!=solar.getSize()-1)
            logfile << ",";
    }
    logfile << std::endl;
}