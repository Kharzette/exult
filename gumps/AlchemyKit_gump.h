/*
Copyright (C) 2001-2013 The Exult Team

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*/

//KZ - copied most of this from Jawbone
#ifndef ALCHEMY_KIT_GUMP_H
#define	ALCHEMY_KIT_GUMP_H

#include "Gump.h"

class Game_object;
class Container_game_object;
class Game_window;
class AlchemyKit_object;

class AlchemyKit_gump : public Gump
{
public:
	AlchemyKit_gump(AlchemyKit_object *pKit, int initx, int inity);

	// Add object.
	bool add(Game_object *obj, int mx = -1, int my = -1,
	        int sx = -1, int sy = -1, bool dont_check = false,
	        bool combine = false) override;

private:

	AlchemyKit_object	*mpKit;

};

#endif	//ALCHEMY_KIT_GUMP_H