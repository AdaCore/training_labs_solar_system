///////////////////////////////////////////////////////////////////////
//                              Ada Labs                             //
//                                                                   //
//                 Copyright (C) 2008-2023, AdaCore                  //
//                                                                   //
// Labs is free  software; you can redistribute it and/or modify  it //
// under the terms of the GNU General Public License as published by //
// the Free Software Foundation; either version 2 of the License, or //
// (at your option) any later version.                               //
//                                                                   //
// This program is  distributed in the hope that it will be  useful, //
// but  WITHOUT ANY WARRANTY;  without even the  implied warranty of //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU //
// General Public License for more details. You should have received //
// a copy of the GNU General Public License along with this program; //
// if not,  write to the  Free Software Foundation, Inc.,  59 Temple //
// Place - Suite 330, Boston, MA 02111-1307, USA.                    //
///////////////////////////////////////////////////////////////////////

#include "compute.h"
#include <stdio.h>

// Import ada_cos and ada_sin so that we can call them
extern float ada_cos(float x);
extern float ada_sin(float x);

// Actual computation
float compute_x(const body_t *body_to_move) {
    if(body_to_move->turns_around) {
        return body_to_move->turns_around->x +
            body_to_move->distance * ada_cos(body_to_move->angle);
    } else {
        return body_to_move->x;
    }
}

float compute_y(const body_t *body_to_move) {
    if(body_to_move->turns_around) {
        return body_to_move->turns_around->y +
            body_to_move->distance * ada_sin(body_to_move->angle);
    } else {
        return body_to_move->y;
    }
}
