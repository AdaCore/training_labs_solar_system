///////////////////////////////////////////////////////////////////////
//                              Ada Labs                             //
//                                                                   //
//                 Copyright (C) 2008-2023, AdaCore                  //
//                                                                   //
// This program is free software: you can redistribute it and/or     //
// modify it under the terms of the GNU General Public License as    //
// published by the Free Software Foundation, either version 3 of    //
// the License, or (at your option) any later version.               //
//                                                                   //
// This program is distributed in the hope that it will be useful,   //
// but WITHOUT ANY WARRANTY; without even the implied warranty of    //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the     //
// GNU General Public License for more details.                      //
//                                                                   //
// You should have received a copy of the GNU General Public License //
// along with this program.  If not, see                             //
// <https://www.gnu.org/licenses/>.                                  //
///////////////////////////////////////////////////////////////////////

#pragma once
#ifndef COMPUTE_C_H
#define COMPUTE_C_H

#include <stdbool.h>

// Data structures shared with Ada

typedef struct rgba_t {
    unsigned char r;
    unsigned char g;
    unsigned char b;
    unsigned char a;
} rgba_t;

typedef struct body_t {
    float x;
    float y;
    float distance;
    float speed;
    float angle;
    float radius;
    rgba_t color;
    bool visible;
    struct body_t *turns_around;
} body_t;

// Operations

float compute_x(const body_t *body_to_move);
float compute_y(const body_t *body_to_move);

#endif // COMPUTE_C_H
